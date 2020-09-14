setwd('C:/Users/dwald/OneDrive/ZenBook backup/Blog/Data/FEC/fecfile')
library(data.table)
library(magrittr)
library(LaF)

# WinRed 2019H1 data
laf_winred1 <- laf_open_csv('1345864.csv',
                            column_types = c('character'),
                            sep = '°')

dt_winred1 <- data.table(month = '',
                         freq = 0,
                         amount = 0,
                         occupation = '')[0]

for(i in 0:floor((nrow(laf_winred1)/1e5))){
  print(i)
  dt_cur <- next_block(laf_winred1, nrows = 1e5) %>%
    data.table()
  
  dt_cur <- read.table(text = as.character(dt_cur$V1),
                       sep = ",",
                       as.is = TRUE,
                       fill = TRUE,
                       check.names = FALSE) %>%
    data.table() %>%
    .[V6 == 'IND']
  
  if (nrow(dt_cur) > 0) {
    dt_cur <- dt_cur %>%
      .[,
        .(freq = .N,
          amount = sum(as.numeric(V21))),
        .(month = substr(V20,1,6),
          occupation = V25)]
    
    dt_winred1 <- rbind(dt_winred1, dt_cur)
  }
}

fwrite(dt_winred1, 'winred2019H1_occ.csv')

# WinRed 2019H2 data
laf_winred2 <- laf_open_csv('1376015.csv',
                            column_types = c('character'),
                            sep = '°')

dt_winred2 <- data.table(month = '',
                         freq = 0,
                         amount = 0,
                         occupation = '')[0]

for(i in 0:floor((nrow(laf_winred2)/1e5))){
  print(i)
  dt_cur <- next_block(laf_winred2, nrows = 1e5) %>%
    data.table()
  
  dt_cur <- read.table(text = as.character(dt_cur$V1),
                       sep = ",",
                       as.is = TRUE,
                       fill = TRUE,
                       check.names = FALSE) %>%
    data.table() %>%
    .[V6 == 'IND']
  
  if (nrow(dt_cur) > 0) {
    dt_cur <- dt_cur %>%
      .[,
        .(freq = .N,
          amount = sum(as.numeric(V21))),
        .(month = substr(V20,1,6),
          occupation = V25)]
    
    dt_winred2 <- rbind(dt_winred2, dt_cur)
  }
}

fwrite(dt_winred2, 'winred2019H2_occ.csv')

# ActBlue 2019H1 data
laf_actblue1 <- laf_open_csv('1344765.csv',
                            column_types = c('character'),
                            sep = '°')

dt_actcblue1 <- data.table(month = '',
                         freq = 0,
                         amount = 0,
                         occupation = '')[0]

for(i in 0:floor((nrow(laf_actblue1)/1e5))){
  print(i)
  dt_cur <- next_block(laf_actblue1, nrows = 1e5) %>%
    data.table()
  
  dt_cur <- read.table(text = as.character(dt_cur$V1),
                       sep = ",",
                       as.is = TRUE,
                       fill = TRUE,
                       check.names = FALSE) %>%
    data.table() %>%
    .[V6 == 'IND']
  
  if (nrow(dt_cur) > 0) {
    dt_cur <- dt_cur %>%
      .[,
        .(freq = .N,
          amount = sum(as.numeric(V21))),
        .(month = substr(V20,1,6),
          occupation = V25)]
    
    dt_actcblue1 <- rbind(dt_actcblue1, dt_cur)
  }
}

fwrite(dt_actcblue1, 'actblue2019H1_occ.csv')

# ActBlue 2019H2 data
laf_actcblue2 <- laf_open_csv('1378435.csv',
                            column_types = c('character'),
                            sep = '°')

dt_actcblue2 <- data.table(month = '',
                         freq = 0,
                         amount = 0,
                         occupation = '')[0]

for(i in 0:floor((nrow(laf_actcblue2)/1e5))){
  print(i)
  dt_cur <- next_block(laf_actcblue2, nrows = 1e5) %>%
    data.table()
  
  dt_cur <- read.table(text = as.character(dt_cur$V1),
                       sep = ",",
                       as.is = TRUE,
                       fill = TRUE,
                       check.names = FALSE) %>%
    data.table() %>%
    .[V6 == 'IND']
  
  if (nrow(dt_cur) > 0) {
    dt_cur <- dt_cur %>%
      .[,
        .(freq = .N,
          amount = sum(as.numeric(V21))),
        .(month = substr(V20,1,6),
          occupation = V25)]
    
    dt_actcblue2 <- rbind(dt_actcblue2, dt_cur)
  }
}

fwrite(dt_actcblue2, 'actblue2019H2_occ.csv')