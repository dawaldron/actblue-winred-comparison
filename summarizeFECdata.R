setwd('C:/Users/dwald/OneDrive/ZenBook backup/Blog/Data/FEC/fecfile')
library(data.table)
library(magrittr)
library(LaF)


# Load WinRed data
dt_winred1 <- fread('winred2019H1_occ.csv')
dt_winred2 <- fread('winred2019H2_occ.csv')

dt_winred <- rbind(dt_winred1, dt_winred2) %>%
  .[,
    .(freq = sum(freq),
      amount = sum(amount)),
    .(month, occupation = toupper(occupation))]

# Terms used to indicate not working in the occupation field
dt_nwt <- fread('notworkingterms.tsv')

# WinRed 2019 data by month
dt_winred.sum <- dt_nwt[dt_winred, on = 'occupation'] %>%
  .[!is.na(reason) & reason != 'Retired', reason := 'Not employed'] %>%
  .[is.na(reason), reason := 'Employed'] %>%
  .[,
    .(freq = sum(freq),
      amount = sum(amount)),
    .(month, reason)] %>%
  .[, pct := freq / sum(freq), month]

# Summary of WinRed 2019 data
dt_winred.sum[, .(freq = sum(freq), amount = sum(amount)), reason] %>%
  .[, .(reason, amount, freq, pct = freq / sum(freq))]

fwrite(dt_winred.sum, 'wrsummary.csv')

# Load ActBlue data
dt_actblue1 <- fread('actblue2019H1_occ.csv')
dt_actblue2 <- fread('actblue2019H2_occ.csv')

dt_actblue <- rbind(dt_actblue1, dt_actblue2) %>%
  .[,
    .(freq = sum(freq),
      amount = sum(amount)),
    .(month, occupation = toupper(occupation))]

# ActBlue 2019 data by month
dt_actblue.sum <- dt_nwt[dt_actblue, on = 'occupation'] %>%
  .[!is.na(reason) & reason != 'Retired', reason := 'Not employed'] %>%
  .[is.na(reason), reason := 'Employed'] %>%
  .[,
    .(freq = sum(freq),
      amount = sum(amount)),
    .(month, reason)] %>%
  .[, pct := freq / sum(freq), month]

# Summary of ActBlue 2019 data
dt_actblue.sum[, .(freq = sum(freq), amount = sum(amount)), reason] %>%
  .[, .(reason, amount, freq, pct = freq / sum(freq))]

fwrite(dt_actblue.sum, 'absummary.csv')
