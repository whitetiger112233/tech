#!../../bin/linux-arm/KKTech

cd "/usr/local/epics/iocs/KKTech/iocBoot/iocKKTech"
< envPaths
< pvSettings

cd "$(TOP)"

## Register all support components
dbLoadDatabase("dbd/KKTech.dbd")
KKTech_registerRecordDeviceDriver(pdbbase) 

## Serial Configuration
drvAsynSerialPortConfigure("SERIALPORT","/dev/ttyAMA0",0,0,0)
asynSetOption("SERIALPORT",-1,"baud","19200")
asynSetOption("SERIALPORT",-1,"bits","8")
asynSetOption("SERIALPORT",-1,"parity","odd")
asynSetOption("SERIALPORT",-1,"stop","1")
asynSetOption("SERIALPORT",-1,"clocal","Y")
asynSetOption("SERIALPORT",-1,"crtscts","N")
asynOctetSetInputEos("SERIALPORT",0,"\r")
asynOctetSetOutputEos("SERIALPORT",0,"\r")

KKTechSetup(1,8,10)
KKTechConfig(0,"SERIALPORT")

## Load record instances
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M1),S=0"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M2),S=1"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M3),S=2"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M4),S=3"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M5),S=4"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M6),S=5"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M7),S=6"
dbLoadRecords "db/motor_record.db","P=$(P),M=$(M8),S=7"

#dbLoadRecords "db/motorUtil.db","P=$(P)"

# =====================================================================
## Begin: Setup autosave/restore
# =====================================================================

# ============================================================
# If all PVs don't connect continue anyway
# ============================================================
save_restoreSet_IncompleteSetsOk(1)

# ============================================================
# created save/restore backup files with date string
# useful for recovery.
# ============================================================
save_restoreSet_DatedBackupFiles(0)

# ============================================================
# Where to find the list of PVs to save
# ============================================================
set_requestfile_path("./")

# ============================================================
# Where to write the save files that will be used to restore
# ============================================================
set_savefile_path("./", "autosave")

# ============================================================
# Prefix that is use to update save/restore status database
# records
# ============================================================
#save_restoreSet_status_prefix("$(LOCA):$(DEV):")
#save_restoreSet_status_prefix("$(P)")

## Restore datasets
set_pass0_restoreFile("auto_settings.sav")
set_pass1_restoreFile("auto_settings.sav")

# =====================================================================
# End: Setup autosave/restore
# =====================================================================


## Set this to see messages from mySub
#var mySubDebug 1

## Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

#motorUtilInit("$(P)")

create_monitor_set("auto_settings.req", 30, "P=$(P),M1=$(M1),M2=$(M2),M3=$(M3),M4=$(M4),M5=$(M5),M6=$(M6),M7=$(M7),M8=$(M8)")


## Start any sequence programs
#seq sncKKTech,"user=root"
