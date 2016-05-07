#
#  Copyright (c) 2011-2012, ARM Limited. All rights reserved.
#  Copyright (c) 2015, Hisilicon Limited. All rights reserved.
#  Copyright (c) 2015, Linaro Limited. All rights reserved.
#
#  This program and the accompanying materials
#  are licensed and made available under the terms and conditions of the BSD License
#  which accompanies this distribution.  The full text of the license may be found at
#  http://opensource.org/licenses/bsd-license.php
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
#  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
#

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = Pv660D02
  PLATFORM_GUID                  = E1AB8AC3-3EF1-4c6f-8D9F-ABE3EC67188E
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = OpenPlatformPkg/Platforms/Hisilicon/D02/$(PLATFORM_NAME).fdf
  DEFINE EDK2_SKIP_PEICORE=0
  DEFINE INCLUDE_TFTP_COMMAND=1

!include OpenPlatformPkg/Chips/Hisilicon/Pv660/Pv660.dsc.inc

[LibraryClasses.common]
  ArmLib|ArmPkg/Library/ArmLib/AArch64/AArch64Lib.inf
  ArmPlatformLib|OpenPlatformPkg/Chips/Hisilicon/Library/ArmPlatformLibPv660/ArmPlatformLib.inf

  ArmPlatformSysConfigLib|ArmPlatformPkg/ArmVExpressPkg/Library/ArmVExpressSysConfigLib/ArmVExpressSysConfigLib.inf
  NorFlashPlatformLib|ArmPlatformPkg/ArmVExpressPkg/Library/NorFlashArmVExpressLib/NorFlashArmVExpressLib.inf
  LcdPlatformLib|ArmPlatformPkg/ArmVExpressPkg/Library/PL111LcdArmVExpressLib/PL111LcdArmVExpressLib.inf
  I2CLib|OpenPlatformPkg/Chips/Hisilicon/Library/I2CLib/I2CLib.inf
  TimerLib|ArmPkg/Library/ArmArchTimerLib/ArmArchTimerLib.inf
  NetLib|MdeModulePkg/Library/DxeNetLib/DxeNetLib.inf
  DpcLib|MdeModulePkg/Library/DxeDpcLib/DxeDpcLib.inf
  HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  UefiScsiLib|MdePkg/Library/UefiScsiLib/UefiScsiLib.inf
  UdpIoLib|MdeModulePkg/Library/DxeUdpIoLib/DxeUdpIoLib.inf
  IpIoLib|MdeModulePkg/Library/DxeIpIoLib/DxeIpIoLib.inf

  CpldIoLib|OpenPlatformPkg/Chips/Hisilicon/Library/CpldIoLib/CpldIoLib.inf

  SerdesLib|OpenPlatformPkg/Chips/Hisilicon/Binary/Pv660/Library/Pv660Serdes/Pv660SerdesLib.inf

  RealTimeClockLib|OpenPlatformPkg/Chips/Hisilicon/Library/VirtualRealTimeClockLib/RealTimeClockLib.inf
  OemMiscLib|OpenPlatformPkg/Platforms/Hisilicon/D02/Library/OemMiscLibD02/OemMiscLibD02.inf
  OemAddressMapLib|OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/Library/AddressMapPv660D02/OemAddressMapPv660D02.inf
  PlatformSysCtrlLib|OpenPlatformPkg/Chips/Hisilicon/Binary/Pv660/Library/PlatformSysCtrlLibPv660/PlatformSysCtrlLibPv660.inf

  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibNull/DxeCapsuleLibNull.inf
  GenericBdsLib|IntelFrameworkModulePkg/Library/GenericBdsLib/GenericBdsLib.inf
  PlatformBdsLib|OpenPlatformPkg/Chips/Hisilicon/Override/ArmVirtPkg/Library/PlatformIntelBdsLib/PlatformIntelBdsLib.inf
  CustomizedDisplayLib|MdeModulePkg/Library/CustomizedDisplayLib/CustomizedDisplayLib.inf

[LibraryClasses.common.SEC]
  ArmLib|ArmPkg/Library/ArmLib/AArch64/AArch64LibSec.inf
  ArmPlatformLib|OpenPlatformPkg/Chips/Hisilicon/Library/ArmPlatformLibPv660/ArmPlatformLibSec.inf

[LibraryClasses.common.DXE_RUNTIME_DRIVER]
  I2CLib|OpenPlatformPkg/Chips/Hisilicon/Library/I2CLib/I2CLibRuntime.inf

[BuildOptions]
  GCC:*_*_AARCH64_ARCHCC_FLAGS  = -DARM_CPU_AARCH64
  GCC:*_*_AARCH64_PP_FLAGS  = -DARM_CPU_AARCH64
  GCC:*_*_AARCH64_PLATFORM_FLAGS == -I$(WORKSPACE)/ArmPlatformPkg/ArmVExpressPkg/Include -I$(WORKSPACE)/ArmPlatformPkg/ArmVExpressPkg/Include/Platform/RTSM -I$(WORKSPACE)/OpenPlatformPkg/Chips/Hisilicon/Pv660/Include

[BuildOptions.AARCH64.EDKII.UEFI_APPLICATION]
  GCC:*_*_*_CC_FLAGS = -mcmodel=small -falign-functions=16
  GCC:*_*_*_DLINK_FLAGS = -z common-page-size=0x1000 --sort-section=alignment


################################################################################
#
# Pcd Section - list of all EDK II PCD Entries defined by this Platform
#
################################################################################

[PcdsFeatureFlag.common]

!if $(EDK2_SKIP_PEICORE) == 1
  gArmPlatformTokenSpaceGuid.PcdSystemMemoryInitializeInSec|TRUE
  gArmPlatformTokenSpaceGuid.PcdSendSgiToBringUpSecondaryCores|TRUE
!endif

  ## If TRUE, Graphics Output Protocol will be installed on virtual handle created by ConsplitterDxe.
  #  It could be set FALSE to save size.
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutGopSupport|FALSE

[PcdsFixedAtBuild.common]
  gArmPlatformTokenSpaceGuid.PcdFirmwareVendor|"ARM Versatile Express"
  gEmbeddedTokenSpaceGuid.PcdEmbeddedPrompt|"D02"

  gArmPlatformTokenSpaceGuid.PcdCoreCount|8

  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000

  # Stacks for MPCores in Secure World
  gArmPlatformTokenSpaceGuid.PcdCPUCoresSecStackBase|0xE1000000
  gArmPlatformTokenSpaceGuid.PcdCPUCoreSecPrimaryStackSize|0x10000

  # Stacks for MPCores in Monitor Mode
  gArmPlatformTokenSpaceGuid.PcdCPUCoresSecMonStackBase|0xE100FF00
  gArmPlatformTokenSpaceGuid.PcdCPUCoreSecMonStackSize|0x100

  # Stacks for MPCores in Normal World
  gArmPlatformTokenSpaceGuid.PcdCPUCoresStackBase|0xE1000000
  gArmPlatformTokenSpaceGuid.PcdCPUCorePrimaryStackSize|0xFF00

  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x00000000
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x3FC00000

  # Size of the region used by UEFI in permanent memory (Reserved 64MB)
  gArmPlatformTokenSpaceGuid.PcdSystemMemoryUefiRegionSize|0x10000000

  #
  # ARM Pcds
  #
  gArmTokenSpaceGuid.PcdArmUncachedMemoryMask|0x0000000040000000

  #
  # ARM PrimeCell
  #


  ## SP805 Watchdog - Motherboard Watchdog
  gArmPlatformTokenSpaceGuid.PcdSP805WatchdogBase|0x801e0000

  ## Serial Terminal
  gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase|0x80300000
  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultBaudRate|115200

  gHisiTokenSpaceGuid.PcdUartClkInHz|200000000

  gHisiTokenSpaceGuid.PcdSerialPortSendDelay|10000000

  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultDataBits|8
  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultParity|1
  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultStopBits|1

  gHisiTokenSpaceGuid.PcdM3SmmuBaseAddress|0xa0040000
  gHisiTokenSpaceGuid.PcdPcieSmmuBaseAddress|0xb0040000
  gHisiTokenSpaceGuid.PcdDsaSmmuBaseAddress|0xc0040000
  gHisiTokenSpaceGuid.PcdAlgSmmuBaseAddress|0xd0040000
  gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString|L"Estuary v2.2 D02 UEFI"

  gHisiTokenSpaceGuid.PcdSystemProductName|L"D02"
  gHisiTokenSpaceGuid.PcdSystemVersion|L"Estuary"
  gHisiTokenSpaceGuid.PcdBaseBoardProductName|L"D02"
  gHisiTokenSpaceGuid.PcdBaseBoardVersion|L"Estuary"

  gHisiTokenSpaceGuid.PcdSlotPerChannelNum|0x2

  #
  # ARM PL390 General Interrupt Controller
  #
  gArmTokenSpaceGuid.PcdGicDistributorBase|0x8D000000
  gArmTokenSpaceGuid.PcdGicInterruptInterfaceBase|0xFE000000
  gArmTokenSpaceGuid.PcdGicRedistributorsBase|0x8D100000
  gHisiTokenSpaceGuid.PcdNORFlashBase|0x90000000
  gHisiTokenSpaceGuid.PcdNORFlashCachableSize|0x8000000

  #
  # ARM OS Loader
  #
  # Versatile Express machine type (ARM VERSATILE EXPRESS = 2272) required for ARM Linux:
  gArmPlatformTokenSpaceGuid.PcdDefaultBootDescription|L"Linux from SATA"
  gArmPlatformTokenSpaceGuid.PcdDefaultBootDevicePath|L"EFI\GRUB2\grubaa64.efi"
  gArmPlatformTokenSpaceGuid.PcdDefaultBootArgument|""

  # Use the serial console (ConIn & ConOut) and the Graphic driver (ConOut)
  gArmPlatformTokenSpaceGuid.PcdDefaultConOutPaths|L"VenHw(D3987D4B-971A-435F-8CAF-4967EB627241)/Uart(115200,8,N,1)/VenPcAnsi();VenHw(407B4008-BF5B-11DF-9547-CF16E0D72085)"
  gArmPlatformTokenSpaceGuid.PcdDefaultConInPaths|L"VenHw(D3987D4B-971A-435F-8CAF-4967EB627241)/Uart(115200,8,N,1)/VenPcAnsi()"

  #
  # ARM Architectual Timer Frequency
  #
  gArmTokenSpaceGuid.PcdArmArchTimerFreqInHz|50000000

  gHisiTokenSpaceGuid.PcdSysControlBaseAddress|0x80010000
  gHisiTokenSpaceGuid.PcdMailBoxAddress|0x0000FFF8
  gHisiTokenSpaceGuid.PcdCpldBaseAddress|0x98000000
  gHisiTokenSpaceGuid.PcdSFCCFGBaseAddress|0xA6000000
  gHisiTokenSpaceGuid.PcdSFCMEM0BaseAddress|0xA4000000

  gHisiTokenSpaceGuid.PcdRamDiskMaxSize|128

  gHisiTokenSpaceGuid.PcdPeriSubctrlAddress|0x80000000

  gHisiTokenSpaceGuid.PcdMdioSubctrlAddress|0x80000000

  ## 1 SCCL + 1 SICL
  gHisiTokenSpaceGuid.PcdPlatformDefaultPackageType|0x0
  gHisiTokenSpaceGuid.PcdArmPrimaryCoreTemp|0x80020000
  gHisiTokenSpaceGuid.PcdTopOfLowMemory|0x80000000
  gHisiTokenSpaceGuid.PcdBottomOfHighMemory|0x1000000000
  gHisiTokenSpaceGuid.PcdTrustedFirmwareEnable|0x1

  gEfiMdeModulePkgTokenSpaceGuid.PcdResetOnMemoryTypeInformationChange|FALSE
  gEfiIntelFrameworkModulePkgTokenSpaceGuid.PcdShellFile|{ 0x83, 0xA5, 0x04, 0x7C, 0x3E, 0x9E, 0x1C, 0x4F, 0xAD, 0x65, 0xE0, 0x52, 0x68, 0xD0, 0xB4, 0xD1 }

  ## SP804 DualTimer
  gArmPlatformTokenSpaceGuid.PcdSP804TimerFrequencyInMHz|200
  gArmPlatformTokenSpaceGuid.PcdSP804TimerPeriodicInterruptNum|304
  gArmPlatformTokenSpaceGuid.PcdSP804TimerPeriodicBase|0x80060000
  ## TODO: need to confirm the base for Performance and Metronome base for PV660
  gArmPlatformTokenSpaceGuid.PcdSP804TimerPerformanceBase|0x80060000
  gArmPlatformTokenSpaceGuid.PcdSP804TimerMetronomeBase|0x80060000

################################################################################
#
# Components Section - list of all EDK II Modules needed by this Platform
#
################################################################################
[Components.common]
  #
  # PEI Phase modules
  #
!if $(EDK2_SKIP_PEICORE) == 1
  ArmPlatformPkg/PrePi/PeiMPCore.inf {
    <LibraryClasses>
      ArmLib|ArmPkg/Library/ArmLib/AArch64/AArch64Lib.inf
      ArmPlatformLib|OpenPlatformPkg/Chips/Hisilicon/Library/ArmPlatformLibPv660/ArmPlatformLib.inf
      ArmPlatformGlobalVariableLib|ArmPlatformPkg/Library/ArmPlatformGlobalVariableLib/PrePi/PrePiArmPlatformGlobalVariableLib.inf
  }
  ArmPlatformPkg/PrePi/PeiUniCore.inf {
    <LibraryClasses>
      ArmLib|ArmPkg/Library/ArmLib/AArch64/AArch64Lib.inf
      ArmPlatformLib|OpenPlatformPkg/Chips/Hisilicon/Library/ArmPlatformLibPv660/ArmPlatformLib.inf
      ArmPlatformGlobalVariableLib|ArmPlatformPkg/Library/ArmPlatformGlobalVariableLib/PrePi/PrePiArmPlatformGlobalVariableLib.inf
  }
!else
  ArmPlatformPkg/PrePeiCore/PrePeiCoreMPCore.inf
  MdeModulePkg/Core/Pei/PeiMain.inf
  MdeModulePkg/Universal/PCD/Pei/Pcd.inf
  ArmPlatformPkg/PlatformPei/PlatformPeim.inf
  OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/MemoryInitPei/MemoryInitPeim.inf
  ArmPkg/Drivers/CpuPei/CpuPei.inf
  IntelFrameworkModulePkg/Universal/StatusCode/Pei/StatusCodePei.inf
  MdeModulePkg/Universal/FaultTolerantWritePei/FaultTolerantWritePei.inf
  MdeModulePkg/Universal/Variable/Pei/VariablePei.inf
  OpenPlatformPkg/Platforms/Hisilicon/D02/EarlyConfigPeim/EarlyConfigPeim.inf
  OpenPlatformPkg/Chips/Hisilicon/Drivers/VersionInfoPeim/VersionInfoPeim.inf

  MdeModulePkg/Core/DxeIplPeim/DxeIpl.inf {
    <LibraryClasses>
      NULL|IntelFrameworkModulePkg/Library/LzmaCustomDecompressLib/LzmaCustomDecompressLib.inf
  }
!endif

  #
  # DXE
  #
  MdeModulePkg/Core/Dxe/DxeMain.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Library/DxeCrc32GuidedSectionExtractLib/DxeCrc32GuidedSectionExtractLib.inf
  }
  MdeModulePkg/Universal/PCD/Dxe/Pcd.inf

  OpenPlatformPkg/Chips/Hisilicon/Pv660/Drivers/IoInitDxe/IoInitDxe.inf

  #
  # Architectural Protocols
  #
  ArmPkg/Drivers/CpuDxe/CpuDxe.inf
  MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf


  OpenPlatformPkg/Platforms/Hisilicon/D02/OemNicConfigD02/OemNicConfigD02.inf

  OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/Drivers/SFC/SfcDxeDriver.inf

  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
  MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe.inf
  OpenPlatformPkg/Chips/Hisilicon/Drivers/FlashFvbDxe/FlashFvbDxe.inf
  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
  }
  MdeModulePkg/Universal/CapsuleRuntimeDxe/CapsuleRuntimeDxe.inf
  MdeModulePkg/Universal/FaultTolerantWriteDxe/FaultTolerantWriteDxe.inf
  EmbeddedPkg/EmbeddedMonotonicCounter/EmbeddedMonotonicCounter.inf

  MdeModulePkg/Universal/MonotonicCounterRuntimeDxe/MonotonicCounterRuntimeDxe.inf
  EmbeddedPkg/ResetRuntimeDxe/ResetRuntimeDxe.inf
  EmbeddedPkg/RealTimeClockRuntimeDxe/RealTimeClockRuntimeDxe.inf
  EmbeddedPkg/MetronomeDxe/MetronomeDxe.inf

  MdeModulePkg/Universal/Console/ConPlatformDxe/ConPlatformDxe.inf
  MdeModulePkg/Universal/Console/ConSplitterDxe/ConSplitterDxe.inf
  MdeModulePkg/Universal/Console/GraphicsConsoleDxe/GraphicsConsoleDxe.inf
  MdeModulePkg/Universal/Console/TerminalDxe/TerminalDxe.inf
  MdeModulePkg/Universal/SerialDxe/SerialDxe.inf

  # Simple TextIn/TextOut for UEFI Terminal
  EmbeddedPkg/SimpleTextInOutSerial/SimpleTextInOutSerial.inf

  MdeModulePkg/Universal/HiiDatabaseDxe/HiiDatabaseDxe.inf

  ArmPkg/Drivers/ArmGic/ArmGicDxe.inf

  #ArmPkg/Drivers/TimerDxe/TimerDxe
  ArmPlatformPkg/Drivers/SP804TimerDxe/SP804TimerDxe.inf
  ArmPlatformPkg/Drivers/SP805WatchdogDxe/SP805WatchdogDxe.inf

  IntelFrameworkModulePkg/Universal/StatusCode/RuntimeDxe/StatusCodeRuntimeDxe.inf

  #
  #network
  #
  OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/Drivers/SnpPV600Dxe_PLAT/SnpPV600DxeMac4PhyInitOnly.inf
  OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/Drivers/SnpPV600Dxe_PLAT/SnpPV600DxeMac5.inf
  MdeModulePkg/Universal/Network/ArpDxe/ArpDxe.inf
  MdeModulePkg/Universal/Network/Dhcp4Dxe/Dhcp4Dxe.inf
  MdeModulePkg/Universal/Network/DpcDxe/DpcDxe.inf
  MdeModulePkg/Universal/Network/Ip4Dxe/Ip4Dxe.inf
  MdeModulePkg/Universal/Network/MnpDxe/MnpDxe.inf
  MdeModulePkg/Universal/Network/Mtftp4Dxe/Mtftp4Dxe.inf
  MdeModulePkg/Universal/Network/Tcp4Dxe/Tcp4Dxe.inf
  MdeModulePkg/Universal/Network/Udp4Dxe/Udp4Dxe.inf
  MdeModulePkg/Universal/Network/UefiPxeBcDxe/UefiPxeBcDxe.inf
  MdeModulePkg/Universal/Network/VlanConfigDxe/VlanConfigDxe.inf

  #
  # FAT filesystem + GPT/MBR partitioning
  #
  OpenPlatformPkg/Chips/Hisilicon/Drivers/ramdisk/ramdisk.inf
  MdeModulePkg/Universal/Disk/DiskIoDxe/DiskIoDxe.inf
  MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe.inf
  MdeModulePkg/Universal/Disk/UnicodeCollation/EnglishDxe/EnglishDxe.inf

  OpenPlatformPkg/Platforms/Hisilicon/Binary/D02/Ebl/Ebl.inf
  MdeModulePkg/Application/HelloWorld/HelloWorld.inf
  #
  # Bds
  #
  MdeModulePkg/Universal/DevicePathDxe/DevicePathDxe.inf

  #
  # Memory test
  #
  MdeModulePkg/Universal/MemoryTest/GenericMemoryTestDxe/GenericMemoryTestDxe.inf

  MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe.inf
  MdeModulePkg/Universal/SetupBrowserDxe/SetupBrowserDxe.inf
  IntelFrameworkModulePkg/Universal/BdsDxe/BdsDxe.inf

  #
  # UEFI application (Shell Embedded Boot Loader)
  #
  ShellPkg/Application/Shell/Shell.inf {
    <LibraryClasses>
      ShellCommandLib|ShellPkg/Library/UefiShellCommandLib/UefiShellCommandLib.inf
      NULL|ShellPkg/Library/UefiShellLevel2CommandsLib/UefiShellLevel2CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellLevel1CommandsLib/UefiShellLevel1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellLevel3CommandsLib/UefiShellLevel3CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellDriver1CommandsLib/UefiShellDriver1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellDebug1CommandsLib/UefiShellDebug1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellInstall1CommandsLib/UefiShellInstall1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellNetwork1CommandsLib/UefiShellNetwork1CommandsLib.inf
      HandleParsingLib|ShellPkg/Library/UefiHandleParsingLib/UefiHandleParsingLib.inf
      PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
      BcfgCommandLib|ShellPkg/Library/UefiShellBcfgCommandLib/UefiShellBcfgCommandLib.inf
!ifdef $(INCLUDE_DP)
      NULL|ShellPkg/Library/UefiDpLib/UefiDpLib.inf
!endif #$(INCLUDE_DP)
!ifdef $(INCLUDE_TFTP_COMMAND)
      NULL|ShellPkg/Library/UefiShellTftpCommandLib/UefiShellTftpCommandLib.inf
!endif #$(INCLUDE_TFTP_COMMAND)

    <PcdsFixedAtBuild>
      gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0xFF
      gEfiShellPkgTokenSpaceGuid.PcdShellLibAutoInitialize|FALSE
      gEfiMdePkgTokenSpaceGuid.PcdUefiLibMaxPrintBufferSize|8000
  }
