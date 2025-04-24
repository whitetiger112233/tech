TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================


#=============================
# Build the IOC application
PROD_IOC = KKTech

# KKTech.dbd will be created and installed
DBD += KKTech.dbd

# KKTech.dbd will be made up from these files:
KKTech_DBD += base.dbd
KKTech_DBD += asyn.dbd
KKTech_DBD += motorSupport.dbd
KKTech_DBD += drvAsynSerialPort.dbd
KKTech_DBD += devKKTech.dbd
KKTech_DBD += calcSupport.dbd
KKTech_DBD += asSupport.dbd
KKTech_DBD += sscanSupport.dbd


# Include dbd files from all support applications:
#KKTech_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#KKTech_LIBS += xxx

# KKTech_registerRecordDeviceDriver.cpp derives from KKTech.dbd
KKTech_SRCS += KKTech_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
KKTech_SRCS_DEFAULT += KKTechMain.cpp
KKTech_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#KKTech_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from our support library
KKTech_LIBS += motor asyn KKMotor autosave calc sscan


# Finally link IOC to the EPICS Base libraries
KKTech_LIBS += $(EPICS_BASE_IOC_LIBS)
KKTech_LIBS += asyn
KKTech_LIBS += motor
KKTech_LIBS += calc
KKTech_LIBS += seq
KKTech_LIBS += autosave
KKTech_LIBS += sscan

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

