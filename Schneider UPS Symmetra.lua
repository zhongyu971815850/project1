--监控: Sechneider Smart-UPS RT 5000 XL SNMP
--MIB：《powernet446.mib》
--项目：丰田项目
--现场：2023.06.05 李旭
--说明：DIO为V6支持的ARRAY_CHAR_64_1类型，现场是用V7，改用lua脚本方式

Model = "Schneider UPS Symmetra"	--监控的设备
MIB = "powernet446.mib"						--软件版本-子版本
Author = "mml"
DATE = "2023/6/5"
Ver = "SNMPLUA-V7-1.0"
Note = "原始数据见sheet2"
QueryOidNum = 10		--每次取OID的数量
Interval = 60				--轮询间隔,秒
DebugLevel = 1			--0:禁用 1:仅记录错误信息wk_Debug(3,...) 2:记录错误和重要调试信息 3:记录全部调试信息				
LogPath = "D:/GNCV7/service/svrlog"	

--SP点表，顺序：spid，相对索引，sp类型，oid，oid类型
--其中sp类型必须是："AIO", "DIO"， "STR","ENUM" 之一
--oid类型有效的是：OID_TYPE_INTEGER,OID_TYPE_ENUM,OID_TYPE_GAUGE,OID_TYPE_COUNTER,
--OID_TYPE_CNTR64,OID_TYPE_UINT32,OID_TYPE_TIME_TICKS,OID_TYPE_IP_ADDRESS,OID_TYPE_OBJECT_IDENTIFIER
--OID_TYPE_OCTET_STRING,OID_TYPE_DATETIME,OID_TYPE_PHYS_ADDRESS
OID_TYPE = {
--[[1--]]  "OID_TYPE_OCTET_STRING",
--[[2--]]  "OID_TYPE_INTEGER",
--[[3--]]  "OID_TYPE_COUNTER",
--[[4--]]  "OID_TYPE_GAUGE",
--[[5--]]  "OID_TYPE_UINT32",
--[[6--]]  "OID_TYPE_CNTR64",
--[[7--]]  "OID_TYPE_ENUM",
--[[8--]]  "OID_TYPE_TIME_TICKS",
--[[9--]]  "OID_TYPE_DATETIME",
--[[10--]] "OID_TYPE_IP_ADDRESS",
--[[11--]] "OID_TYPE_PHYS_ADDRESS",
--[[12--]] "OID_TYPE_OBJECT_IDENTIFIER",
}

--[[
--DIO
--所有设置
--|spid|sptype|index|oid|oidtype|spname|showname|dodesc|d1desc|d0val|d1val|dwvalue|dwlevel|dwmsg|dwtype|dwvtime|ename|end0desc|end1desc|disable|control|save|priority|trap
{spid=0,sptype="DIO",index=0,oid="1.3.6.1.4.1.22853.1.2.1.2.1",spname="DI1",oidtype=2,showname="漏水监测",d0desc="漏水",d1desc="正常",d0val=0,d1val=1,dwvalue=0,dwlevel=2,dwmsg="漏水了",dwtype=1,dwvtime=15,ename="water lake",ed0desc="alarm",ed1desc="normal",disable=1,control=1,save=1,prio=1}, 
--简化设置-带告警
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="漏水监测",d0desc="漏水",d1desc="正常",dwvalue=0,dwlevel=2}, 
--简化设置
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="漏水监测",d0desc="漏水",d1desc="正常"},

--AIO
--所有设置
--|spid|sptype|index|oid|oidtype|spname|showname|ename|precision|unit|sendvar|ratio|sendinterval|awtype|awtime|enwarn1|hilimit1|lolimit1|hi_wmsg1|lo_wmsg1|enwarn2|hilimit2|lolimit2|hi_wmsg2|lo_wmsg2|enwarn3|hilimit3|lolimit3|hi_wmsg3|lo_wmsg3|disable|control|save|priority|trap
{spid=0,sptype="AIO",index=0,oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,spname="AI1",showname="A相电压", ename="voltage of phaseA",precision="0.0",unit="V",sendvar=2,ratio=1,protect=0.5,sendinterval=120,awtype=1,awtime=15,enwarn1=1,hilimit1=242,lolimit1=198,hi_wmsg1="hi1 msg",lo_wmsg1="lo1 msg",enwarn2=1,hilimit2=247,lolimit2=193,hi_wmsg2="hi2 msg", lo_wmsg2="lo1 msg",enwarn3=1,hilimit3=252,lolimit3=188,hi_wmsg3="hi3 msg", lo_wmsg3="lo3 msg",disable=1,control=1,save=1,prio=1},
--简化设置
{sptype="AIO",oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,showname="A相电压", precision="0.0",unit="V",sendvar=2},


--STR
--所有设置
--|spid|sptype|index|oid|oidtype|spname|showname|ename|comptype|compwlevel|swtype|swtime|en_swarn1|s1wstr|s1wmsg|en_swarn2|s2wstr|s2wmsg|en_swarn3|s3wstr|s3wmsg|disable|control|save|priority|trap
{spid=0,sptype="STR",index=0,oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,spname="STR1",showname="IC卡号",ename="IC card",comptype=1,compwlevel=2,swtye=1,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--简化设置
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC卡号",prio=1},


--ENUM
--|spid|sptype|index|oid|oidtype|spname|showname|ename|enumstr|en2umstr|comptype|compwlevel|ewtype|ewtime|en_ewarn1|e1wstr|e1wmsg|en_ewarn2|e2wstr|e2wmsg|en_ewarn3|e3wstr|e3wmsg|disable|control|save|priority|trap
{spid=0,sptype="ENUM",index=0,oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,spname="ENUM1",showname="设备运行状态",ename="operate state",enumstr="0,停止\r\n1,待机\r\n2运行\r\n3,故障",en2umstr="0,stop\r\n1,standby\r\n2running\r\n3,fault",comptype=1,compwlevel=2,ewtype=1,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--简化设置
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="设备运行状态",enumstr="0,停止\r\n1,待机\r\n2运行\r\n3,故障"},
--]]

--prio：0:normal 1:once 2:never(一个OID对应多个SP,或数据需要特别处理的)
--[[
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="漏水监测",d0desc="漏水",d1desc="正常",dwvalue=1,dwlevel=2,dwmsg="漏水了",dwtype=1,dwvtime=15,disable=1,control=1,save=1,prio=1}, 
{sptype="AIO",oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,showname="A相电压",precision="0.0",unit="V",sendvar=2,protect=0.5,sendinterval=120,awtype=1,awtime=15,enwarn1=1,hilimit1=242,lolimit1=198,hi_wmsg1="hi1 msg",lo_wmsg1="lo1 msg",enwarn2=1,hilimit2=247,lolimit2=193,hi_wmsg2="hi2 msg", lo_wmsg2="lo1 msg",enwarn3=1,hilimit3=252,lolimit3=188,hi_wmsg3="hi3 msg", lo_wmsg3="lo3 msg",disable=1,control=1,save=1,prio=1},
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC卡号",comptype=0,compwlevel=2,swtype=0,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC卡号2",comptype=1,compwlevel=2,swtype=1,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="设备运行状态",enumstr="0,停止\r\n1,待机\r\n2运行\r\n3,故障",comptype=0,compwlevel=2,ewtype=0,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="设备运行状态",enumstr="0,停止\r\n1,待机\r\n2运行\r\n3,故障",comptype=1,compwlevel=2,ewtype=1,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--]]

splist={
--[[1 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.1.1.1.0",oidtype=1,showname="UPS型号",prio=1},
--[[2 ]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.2.1.1.0",oidtype=2,showname="电池状态",en2umstr="1,unknown\r\n2,batteryNormal\r\n3,batteryLow\r\n4,batteryInFaultCondition\r\n5,noBatteryPresent",enumstr="1,未知\r\n2,电池正常\r\n3,低电量\r\n4,故障\r\n5,未接入"},
--[[3 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.1.2.0",oidtype=8,showname="电池放电时间"},
--[[4 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.1.3.0",oidtype=1,showname="电池上次更换日期",prio=1},
--[[5 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.1.0",oidtype=4,showname="电池剩余电量",unit="%"},
--[[6 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.2.0",oidtype=4,showname="电池温度",unit="℃"},
--[[7 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.2.3.0",oidtype=8,showname="电池剩余时间"},
--[[8 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.4.0",oidtype=2,showname="电池需更换"},
--[[9 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.5.0",oidtype=2,showname="可用电池数量",prio=1},
--[[10]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.6.0",oidtype=2,showname="故障电池数量"},
--[[11]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.8.0",oidtype=2,showname="电池电压",unit="V"},
--[[12]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.9.0",oidtype=2,showname="电池电流",unit="A"},
--[[13]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.10.0",oidtype=2,showname="直流母线电流",unit="A"},
--[[14]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.1.1.0",oidtype=2,showname="输入相数",prio=1},
--[[15]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.1.0",oidtype=4,showname="输入电压",unit="V"},
--[[16]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.2.0",oidtype=4,showname="输入最大电压",unit="V"},
--[[17]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.3.0",oidtype=4,showname="输入最小电压",unit="V"},
--[[18]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.4.0",oidtype=4,showname="输入频率",unit="Hz"},
--[[19]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.3.2.5.0",oidtype=2,showname="输入切换原因",en2umstr="1,noTransfer\r\n2,highLineVoltage\r\n3,brownout\r\n4,blackout\r\n5,smallMomentarySag\r\n6,deepMomentarySag\r\n7,smallMomentarySpike\r\n8,largeMomentarySpike\r\n9,selfTest\r\n10,rateOfVoltageChange",enumstr="1,无切换\r\n2,电压过高\r\n3,持续低电压\r\n4,停电\r\n5,轻度电压下陷\r\n6,深度电压下陷\r\n7,轻度高电压脉冲\r\n8,深度高电压脉冲\r\n9,自测试\r\n10,电压变化率"},
--[[20]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.4.1.1.0",oidtype=2,showname="UPS供电模式",en2umstr="1,unknown\r\n2,onLine\r\n3,onBattery\r\n4,onSmartBoost\r\n5,timedSleeping\r\n6,softwareBypass\r\n7,off\r\n8,rebooting\r\n9,switchedBypass\r\n10,hardwareFailureBypass\r\n11,sleepingUntilPowerReturn\r\n12,onSmartTrim\r\n13,ecoMode\r\n14,hotStandby\r\n15,onBatteryTest\r\n16,emergencyStaticBypass\r\n17,staticBypassStandby\r\n18,powerSavingMode\r\n19,spotMode\r\n20,eConversion\r\n21,chargerSpotmode\r\n22,inverterSpotmode\r\n23,activeLoad\r\n24,batteryDischargeSpotmode\r\n25,inverterStandby\r\n26,chargerOnly\r\n27,distributedEnergyReserve\r\n28,selfTest",enumstr="1,未知\r\n2,在线\r\n3,电池\r\n4,升压\r\n5,定时休眠\r\n6,软旁路\r\n7,关闭\r\n8,重启\r\n9,切旁路\r\n10,硬件故障转旁路\r\n11,休眠至电力恢复\r\n12,斩波\r\n13,ECO\r\n14,待机\r\n15,电池测试\r\n16,紧急静态旁路\r\n17,静态旁路待机\r\n18,节能模式\r\n19,停机\r\n20,转换模式\r\n21,充电器停机\r\n22,逆变停机\r\n23,有功负载\r\n24,电池放电中止\r\n25,逆变待机\r\n26,仅充电\r\n27,分布式能源储备\r\n28,自测试"},
--[[21]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.1.2.0",oidtype=2,showname="输出相数"},
--[[22 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.1.0",oidtype=4,showname="输出电压",unit="V"},
--[[23 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.2.0",oidtype=4,showname="输出频率",unit="Hz"},
--[[24 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.3.0",oidtype=4,showname="输出负载百分比",unit="%"},
--[[25 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.4.0",oidtype=4,showname="输出电流",unit="A"},
--[[26 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.5.0",oidtype=4,prio=2,showname="冗余丢失数量"},
--[[27 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.6.0",oidtype=2,prio=2,showname="最大输出容量",unit="KVA",prio=1},
--[[28 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.8.1.0",oidtype=2,showname="通信状态",d0desc="正常",d1desc="断开",d0val=1,d1val=2,dwvalue=2,dwlevel=1},
--[[29 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=0,showname="UPS异常状态告警",d0desc="正常",d1desc="异常",dwvalue=1,dwlevel=2},
--[[30 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池供电状态",d0desc="非电池供电",d1desc="电池供电",dwvalue=1,dwlevel=2},
--[[31 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池低电量",d0desc="正常",d1desc="电量低",dwvalue=1,dwlevel=2},
--[[32 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS在线",d0desc="不在线",d1desc="在线"},
--[[33 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池需更换",d0desc="不需要",d1desc="到期需更换",dwvalue=1,dwlevel=2},
--[[34 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="串行通信建立",d0desc="未建立",d1desc="建立"},
--[[35 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="自动升压激活",d0desc="否",d1desc="是"},
--[[36 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="自动降压激活",d0desc="否",d1desc="是"},
--[[37 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="超载告警",d0desc="未超载",d1desc="超载",dwvalue=1,dwlevel=2},
--[[38 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="运行时间校准",d0desc="未校准",d1desc="已校准"},
--[[39 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池放电",d0desc="非放电状态",d1desc="放电状态"},
--[[40 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="手动旁路状态",d0desc="非手动旁路状态",d1desc="手动旁路状态",dwvalue=1,dwlevel=2},
--[[41 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="软旁路状态",d0desc="非软件旁路状态",d1desc="软件旁路状态",dwvalue=1,dwlevel=2},
--[[42 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="内部故障转旁路",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[43 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电源供电转旁路",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[44 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="扇故障转旁路",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[45 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="定时休眠状态",d0desc="否",d1desc="是"},
--[[46 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="休眠至市电恢复",d0desc="否",d1desc="是"},
--[[47 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS开机",d0desc="否",d1desc="是"},
--[[48 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="正在重启",d0desc="非重启状态",d1desc="重启中"},
--[[49 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池通信丢失",d0desc="未丢失",d1desc="丢失",dwvalue=1,dwlevel=2},
--[[50 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="启动正常关机",d0desc="未启动",d1desc="正常关机开始"},
--[[51 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="智能升压或降压故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[52 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="输出电压异常",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[53 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池充电器故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[54 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池温度偏高",d0desc="正常",d1desc="电池温度偏高",dwvalue=1,dwlevel=1},
--[[55 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池高温告警",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[56 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池高温严重告警",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=3},
--[[57 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="正在自检",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[58 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池电量低或电池供电",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[59 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="上游设备发出的正常关机",d0desc="否",d1desc="是"},
--[[60 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="下游设备发出的正常关机",d0desc="否",d1desc="是"},
--[[61 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池未连接",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[62 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="正在执行同步命令",d0desc="否",d1desc="是"},
--[[63 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="正在执行同步的休眠命令",d0desc="否",d1desc="是"},
--[[64 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="正在执行同步的重启命令",d0desc="否",d1desc="是"},
--[[65 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="逆变直流不平衡",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[66 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="切换继电器故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[67 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="关机或无法切换",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[68 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池电量低关机",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[69 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电子设备风扇故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[70 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="主继电器故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[71 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="旁路继电器故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[72 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="临时旁路状态",d0desc="否",d1desc="是",dwvalue=1,dwlevel=2},
--[[73 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="内部温度过高",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[74 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="电池温度传感器故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[75 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="旁路输入超限",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[76 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="直流母线过压",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[77 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="PFC故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[78 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="硬件严重故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=3},
--[[79 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="绿色模式或ECO模式",d0desc="否",d1desc="是"},
--[[80 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="热备状态",d0desc="否",d1desc="是"},
--[[81 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="紧急停机(EPO)",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=3},
--[[82 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="负载报警违规",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[83 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="旁路相位故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[84 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS内部通信故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[85 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="高效升压模式",d0desc="否",d1desc="是"},
--[[86 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS关机",d0desc="否",d1desc="是"},
--[[87 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS待机",d0desc="否",d1desc="是"},
--[[88 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="轻微或环境报警",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=1},
--[[89 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=0,showname="电源模块故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[90 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="主智能模块故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[91 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="冗余智能模块故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[92 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="电池故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[93 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="负荷(kVA)报警阈值违规",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[94 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="冗余丢失",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[95 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="冗余低于报警阈值",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[96 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="旁路频率或电压超范围",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[97 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="旁路接触器卡在旁路状态",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[98 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="旁路接触器卡在在线状态",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[99 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="因内部故障处于旁路",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[100]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="因超载处于旁路",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[101]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="处于维护旁路状态",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[102]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="输入断路器设备跳闸开路",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[103]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="系统级风扇故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[104]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="冗余智能模块在被控制",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[105]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="IIC模块间通信故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[106]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="无工作电源模块",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[107]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="负载关机从旁路;输入频率",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[108]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="运行时低于报警阈值",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[109]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="扩展帧运行故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[110]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="输出电压超出范围",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[111]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="UPS不同步",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[112]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="没有安装电池",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[113]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="电池电压高",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[114]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="检测到UPS某个故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[115]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="现场线路故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[116]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="馈电保护继电器开路",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[117]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=0,showname="外部变压器过热 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[118]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="外部开关设备故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[119]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="外部直流断路器跳闸 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[120]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="系统电源故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[121]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="电池监控卡故障",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[122]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="电池监控卡被移除",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[123]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="XR通信卡故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[124]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="XR通信卡被移除",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[125]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="外部开关设备监控卡故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[126]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="外部开关设备监控卡被删除 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[127]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="内部直流断路器跳闸 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[128]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="静态旁路开关故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[129]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="系统EEPROM被移除",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[130]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="系统的EEPROM故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[131]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="UPS被强制旁路 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[132]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="静态旁路开关模块被移除 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[133]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="系统启动配置故障 ",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
--[[134]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="电池充电器外部关机",d0desc="正常",d1desc="告警",dwvalue=1,dwlevel=2},
}

SPListLen = #splist
dcnt,acnt,scnt,ecnt=0,0,0,0
local function Init()
  --注册SP点
  local spid=0
  local Language=wk_GetLanguage();
  for i=1,SPListLen do
		local spitem = splist[i]
		local sptype = spitem.sptype
		spid = i
		spitem.spid = i
		if sptype == "DIO" then
			dcnt = dcnt + 1
			spitem.index = dcnt
			--DIO 脚本中用到的配置，在这里初始化
			spitem.d0val = spitem.d0val or 0
			spitem.d1val = spitem.d1val or 1
		elseif sptype == "AIO" then
			acnt = acnt + 1
			spitem.index = acnt
			--AIO 脚本中用到的配置，在这里初始化
			spitem.ratio = spitem.ratio or 1
		elseif sptype == "STR" then
			scnt = scnt + 1
			spitem.index = scnt
			--STR 脚本中用到的配置，在这里初始化
		else
			ecnt = ecnt + 1
			spitem.index = ecnt
			--ENUM 脚本中用到的配置，在这里初始化
		end
		
		--脚本中用到的配置，在这里初始化，不能和ConfigSP放在一起，否则脚本非第一次运行时这部分变量无法初始化
		--通用设置
		spitem.proc = spitem.proc or false
		spitem.prio = spitem.prio or 0
		--spitem.trap = spitem.trap or 0
		--spitem.control 控制可能脚本中会用到
		
		--对于暂不支持注册的oidtype，注册时先绕过去，就可以不影响后续的类型处理
		--ret=wk_RegistSP(spitem.spid,spitem.index,spitem.sptype,spitem.oid,OID_TYPE[spitem.oidtype==11 and 1 or spitem.oidtype])
		ret=wk_RegistSP(spitem.spid,spitem.index,spitem.sptype,spitem.oid,OID_TYPE[spitem.oidtype])
		--wk_Debug(2,string.format("spid=%d,index=%d,sptype=%s,showname=%s",spitem.spid,spitem.index,spitem.sptype,spitem.showname))
		if ret==0 then --新添加的点，配置初始设置值
			if Language==0 then --中文
				wk_ConfigSP(spid,"showname",spitem.showname)
				if sptype == "DIO" then
					wk_ConfigSP(spid,"d0desc",spitem.d0desc)
					wk_ConfigSP(spid,"d1desc",spitem.d1desc)
				elseif sptype == "ENUM" then
					wk_ConfigSP(spid,"enumstr",spitem.enumstr)
				end
      else
				wk_ConfigSP(spid,"showname",spitem.ename or "")
				if sptype == "DIO" then
					wk_ConfigSP(spid,"d0desc",spitem.end0desc or "0")
					wk_ConfigSP(spid,"d1desc",spitem.end1desc or "1")
				elseif sptype == "ENUM" then
					wk_ConfigSP(spid,"enumstr",spitem.en2umstr or "")
				end
      end
			
			--通用设置
			wk_ConfigSP(spid,"disable",tostring(spitem.disable or 0))
			wk_ConfigSP(spid,"save",tostring(spitem.save or 0))
			wk_ConfigSP(spid,"can_control",tostring(spitem.control or 0))
			
			--DIO
			if sptype == "DIO" then
				wk_ConfigSP(spid,"dwvalue", tostring(spitem.dwvalue or 0))
				wk_ConfigSP(spid,"dwlevel",tostring(spitem.dwlevel or 0))
				wk_ConfigSP(spid,"dwmsg",tostring(spitem.dwmsg or ""))
				wk_ConfigSP(spid,"dwtype",tostring(spitem.dwtype or 0))
				wk_ConfigSP(spid,"dwvtime",tostring(spitem.dwvtime or 0))
				
			--AIO
			elseif sptype == "AIO" then
				wk_ConfigSP(spid,"precision",tostring(spitem.precision or "0"))
				wk_ConfigSP(spid,"unit",tostring(spitem.unit or ""))
				wk_ConfigSP(spid,"sendvar",tostring(spitem.sendvar or 1))
				wk_ConfigSP(spid,"sendinterval",tostring(spitem.sendinterval or 0))
				wk_ConfigSP(spid,"awtype",tostring(spitem.awtype or 0))
				wk_ConfigSP(spid,"awtime",tostring(spitem.awtime or 0))
				wk_ConfigSP(spid,"enwarn1",tostring(spitem.enwarn1 or 0))
				wk_ConfigSP(spid,"hilimit1",tostring(spitem.hilimit1 or 0))
				wk_ConfigSP(spid,"lolimit1",tostring(spitem.lolimit1 or 0))
				wk_ConfigSP(spid,"hi_wmsg1",tostring(spitem.hi_wmsg1 or ""))
				wk_ConfigSP(spid,"lo_wmsg1",tostring(spitem.lo_wmsg1 or ""))
				wk_ConfigSP(spid,"enwarn2",tostring(spitem.enwarn2 or 0))
				wk_ConfigSP(spid,"hilimit2",tostring(spitem.hilimit2 or 0))
				wk_ConfigSP(spid,"lolimit2",tostring(spitem.lolimit2 or 0))
				wk_ConfigSP(spid,"hi_wmsg2",tostring(spitem.hi_wmsg2 or ""))
				wk_ConfigSP(spid,"lo_wmsg2",tostring(spitem.lo_wmsg2 or ""))
				wk_ConfigSP(spid,"enwarn3",tostring(spitem.enwarn3 or 0))
				wk_ConfigSP(spid,"hilimit3",tostring(spitem.hilimit3 or 0))
				wk_ConfigSP(spid,"lolimit3",tostring(spitem.lolimit3 or 0))
				wk_ConfigSP(spid,"hi_wmsg3",tostring(spitem.hi_wmsg3 or ""))
				wk_ConfigSP(spid,"lo_wmsg3",tostring(spitem.lo_wmsg3 or ""))
				
			--STR
			elseif sptype == "STR" then
				wk_ConfigSP(spid,"comptype",tostring(spitem.comptype or 0))
				wk_ConfigSP(spid,"compwlevel",tostring(spitem.compwlevel or 0))
				wk_ConfigSP(spid,"swtype",tostring(spitem.swtype or 0))
				wk_ConfigSP(spid,"swtime",tostring(spitem.swtime or 0))
				wk_ConfigSP(spid,"en_swarn1",tostring(spitem.en_swarn1 or 0))
				wk_ConfigSP(spid,"s1wstr",tostring(spitem.s1wstr or ""))
				wk_ConfigSP(spid,"s1wmsg",tostring(spitem.s1wmsg or ""))
				wk_ConfigSP(spid,"en_swarn2",tostring(spitem.en_swarn2 or 0))
				wk_ConfigSP(spid,"s2wstr",tostring(spitem.s2wstr or ""))
				wk_ConfigSP(spid,"s2wmsg",tostring(spitem.s2wmsg or ""))
				wk_ConfigSP(spid,"en_swarn3",tostring(spitem.en_swarn3 or 0))
				wk_ConfigSP(spid,"s3wstr",tostring(spitem.s3wstr or ""))
				wk_ConfigSP(spid,"s3wmsg",tostring(spitem.s3wmsg or ""))
			
			--ENUM
			elseif sptype == "ENUM" then
				wk_ConfigSP(spid,"enumstr",tostring(spitem.enumstr or ""))
				wk_ConfigSP(spid,"comptype",tostring(spitem.comptype or 0))
				wk_ConfigSP(spid,"compwlevel",tostring(spitem.compwlevel or 0))
				wk_ConfigSP(spid,"ewtype",tostring(spitem.ewtype or 0))
				wk_ConfigSP(spid,"ewtime",tostring(spitem.ewtime or 0))
				wk_ConfigSP(spid,"en_ewarn1",tostring(spitem.en_ewarn1 or 0))
				wk_ConfigSP(spid,"e1wstr",tostring(spitem.e1wstr or ""))
				wk_ConfigSP(spid,"e1wmsg",tostring(spitem.e1wmsg or ""))
				wk_ConfigSP(spid,"en_ewarn2",tostring(spitem.en_ewarn2 or 0))
				wk_ConfigSP(spid,"e2wstr",tostring(spitem.e2wstr or ""))
				wk_ConfigSP(spid,"e2wmsg",tostring(spitem.e2wmsg or ""))
				wk_ConfigSP(spid,"en_ewarn3",tostring(spitem.en_ewarn3 or 0))
				wk_ConfigSP(spid,"e3wstr",tostring(spitem.e3wstr or ""))
				wk_ConfigSP(spid,"e3wmsg",tostring(spitem.e3wmsg or ""))
			end
			wk_ConfigDone(spid)
		end
  end
end

do 
	Init()
end

local sf=string.format
local function Log(str)
	local tm = os.date("*t",os.time())
	--local filename = string.format("D:\\GNCV7\\service\\svrlog\\gncsnmpscript_%04d%02d%02d.log",tm.year,tm.month,tm.day)
	FileName = sf("%s/%s_%04d%02d%02d.log",LogPath,Model or "snmpscript",tm.year,tm.month,tm.day)
	local file = io.open(FileName, "a")
	if file~=nil then
		local timestr = sf("%04d-%02d-%02d %02d:%02d:%02d ",tm.year,tm.month,tm.day,tm.hour,tm.min,tm.sec)
		local logstr = timestr .. str .. "\r\n"
		file:write(logstr)
		file:flush()
		file:close()
	else
		wk_Info("[err] open log file error")
	end
end

local function wk_Debug(level,str)
	if DebugLevel > 0 and level > 3-DebugLevel then
    wk_Info(str)
    if level > 1 then
      Log(str)
    end
	end
end

connect=0 --连接状态
QueryOK=0
QueryFail=0
PollCount=0
RunErr=0
local function exception(err)
	RunErr = RunErr + 1
	wk_Debug(3,err)
end

--转换数据流字符串为16进制打印格式
local function Str2Hex(text, len)
	local ret=""
	for i=1,len or #text do
		ret=ret..sf("%02X ",text:byte(i))
	end
	return ret
end

local function Snmp_TimeTicks(val)
  val = tonumber(val) or 0
  local sec = val // 100
  local day,left = sec // 86400,sec % 86400
  local hour,left = left // 3600,left % 3600
  local minute,left = left // 60,left % 60
	--return sf("%d天%d小时%d分钟%d秒",day,hour,minute,left)
	local sday = day > 0 and sf("%d天",day) or ""
	local shour= hour > 0 and sf("%d小时",hour) or ""
	local smin = minute > 0 and sf("%d分钟",minute) or ""
	local ssec = sf("%d秒",left)
	return sday..shour..smin..ssec
end
			
local function Snmp_DateTime(val)
	return #val>7 and sf("%04d-%02d-%02d %02d:%02d:%02d",string.unpack(">H",val),val:byte(3),val:byte(4),val:byte(5),val:byte(6),val:byte(7)) or val
end

local function Snmp_IPAddress(val)
	return #val==4 and sf("%d.%d.%d.%d",val:byte(1),val:byte(2),val:byte(3),val:byte(4)) or val
end

local function Snmp_PHYSAddress(val)
	--softloopback的mac为空
	return #val==6 and sf("%02X-%02X-%02X-%02X-%02X-%02X",val:byte(1),val:byte(2),val:byte(3),val:byte(4),val:byte(5),val:byte(6)) or val
end

local function wk_ProcSP(spid,val)
	local sptype = splist[spid].sptype
	local spval = tonumber(val)
	if sptype == "DIO" then
		if spid== 8 then
			print(spid,spval,splist[spid].d0val,splist[spid].d1val)
		end
		local d0val = splist[spid].d0val
		local d1val = splist[spid].d1val
		if spval == d0val then
			wk_ProcDIO(spid,0)
		elseif spval == d1val then
			wk_ProcDIO(spid,1)
		else
			wk_Debug(3,sf("[err] ProcDIO value don't match, spid=%d, origin=%s",spid,val))
		end
	elseif sptype == "AIO" then
		if spval == nil then
			spval = 0
			wk_Debug(3,sf("[err] ProcAIO value nil, spid=%d, origin=%s",spid,val))
		end
		local ratio = splist[spid].ratio
		wk_ProcAIO(spid, spval*ratio)
	elseif sptype == "STR" then
		--wk_Debug(3,sf("ProcStr(spid=%d, val=%s, hexstr=%s",spid,val,Str2Hex(val)))
		if splist[spid].oidtype == 8 then  --TIMETICKS转换为 xx天xx时xx分xx秒
			val = Snmp_TimeTicks(val)
		end
		if splist[spid].oidtype == 9 then  --DATETIME转换为2022-03-08 17:03:21
			val = Snmp_DateTime(val)
		end
		if splist[spid].oidtype == 10 then  --IP_ADDRESS转换为127.0.0.1
			val = Snmp_IPAddress(val)
		end
		if splist[spid].oidtype == 11 then  --PHYS_ADDRESS转换为50-E5-49-57-96-F9
			val = Snmp_PHYSAddress(val)
		end
		wk_ProcStr(spid, val)
	else
		if spval == nil then
			spval = 0
			wk_Debug(3,sf("[err] ProcEnum value nil, spid=%d, origin=%s",spid,val))
		end
		wk_ProcEnum(spid, spval)
	end
end

local function wk_SnmpProc(spid, val)
	if spid < 1 or spid > SPListLen then
		wk_Debug(3,"[err] spid out of range")
		return
	end
	if splist[spid].proc == true then
		splist[spid].proc = false
		val = val or splist[spid].val
		wk_ProcSP(spid,val)
		--wk_Debug(3,sf("ProcSP(%d, %s)",spid,val))
	end
end

local function wk_SnmpProcSP()
	--全部proc
	for spid=1,28 do
		wk_SnmpProc(spid)
	end
	
	for spid=29,SPListLen do
		splist[spid].proc = true
	end
	
	local octstr = splist[29].val
	if type(octstr)=="string" then
	wk_SnmpProc(29, octstr:byte(1 )-0x30)
	wk_SnmpProc(30, octstr:byte(2 )-0x30)
	wk_SnmpProc(31, octstr:byte(3 )-0x30)
	wk_SnmpProc(32, octstr:byte(4 )-0x30)
	wk_SnmpProc(33, octstr:byte(5 )-0x30)
	wk_SnmpProc(34, octstr:byte(6 )-0x30)
	wk_SnmpProc(35, octstr:byte(7 )-0x30)
	wk_SnmpProc(36, octstr:byte(8 )-0x30)
	wk_SnmpProc(37, octstr:byte(9 )-0x30)
	wk_SnmpProc(38, octstr:byte(10)-0x30)
	wk_SnmpProc(39, octstr:byte(11)-0x30)
	wk_SnmpProc(40, octstr:byte(12)-0x30)
	wk_SnmpProc(41, octstr:byte(13)-0x30)
	wk_SnmpProc(42, octstr:byte(14)-0x30)
	wk_SnmpProc(43, octstr:byte(15)-0x30)
	wk_SnmpProc(44, octstr:byte(16)-0x30)
	wk_SnmpProc(45, octstr:byte(17)-0x30)
	wk_SnmpProc(46, octstr:byte(18)-0x30)
	wk_SnmpProc(47, octstr:byte(19)-0x30)
	wk_SnmpProc(48, octstr:byte(20)-0x30)
	wk_SnmpProc(49, octstr:byte(21)-0x30)
	wk_SnmpProc(50, octstr:byte(22)-0x30)
	wk_SnmpProc(51, octstr:byte(23)-0x30)
	wk_SnmpProc(52, octstr:byte(24)-0x30)
	wk_SnmpProc(53, octstr:byte(25)-0x30)
	wk_SnmpProc(54, octstr:byte(26)-0x30)
	wk_SnmpProc(55, octstr:byte(27)-0x30)
	wk_SnmpProc(56, octstr:byte(28)-0x30)
	wk_SnmpProc(57, octstr:byte(29)-0x30)
	wk_SnmpProc(58, octstr:byte(30)-0x30)
	wk_SnmpProc(59, octstr:byte(31)-0x30)
	wk_SnmpProc(60, octstr:byte(32)-0x30)
	wk_SnmpProc(61, octstr:byte(33)-0x30)
	wk_SnmpProc(62, octstr:byte(34)-0x30)
	wk_SnmpProc(63, octstr:byte(35)-0x30)
	wk_SnmpProc(64, octstr:byte(36)-0x30)
	wk_SnmpProc(65, octstr:byte(37)-0x30)
	wk_SnmpProc(66, octstr:byte(38)-0x30)
	wk_SnmpProc(67, octstr:byte(39)-0x30)
	wk_SnmpProc(68, octstr:byte(40)-0x30)
	wk_SnmpProc(69, octstr:byte(41)-0x30)
	wk_SnmpProc(70, octstr:byte(42)-0x30)
	wk_SnmpProc(71, octstr:byte(43)-0x30)
	wk_SnmpProc(72, octstr:byte(44)-0x30)
	wk_SnmpProc(73, octstr:byte(45)-0x30)
	wk_SnmpProc(74, octstr:byte(46)-0x30)
	wk_SnmpProc(75, octstr:byte(47)-0x30)
	wk_SnmpProc(76, octstr:byte(48)-0x30)
	wk_SnmpProc(77, octstr:byte(49)-0x30)
	wk_SnmpProc(78, octstr:byte(50)-0x30)
	wk_SnmpProc(79, octstr:byte(51)-0x30)
	wk_SnmpProc(80, octstr:byte(52)-0x30)
	wk_SnmpProc(81, octstr:byte(53)-0x30)
	wk_SnmpProc(82, octstr:byte(54)-0x30)
	wk_SnmpProc(83, octstr:byte(55)-0x30)
	wk_SnmpProc(84, octstr:byte(56)-0x30)
	wk_SnmpProc(85, octstr:byte(57)-0x30)
	wk_SnmpProc(86, octstr:byte(58)-0x30)
	wk_SnmpProc(87, octstr:byte(59)-0x30)
	wk_SnmpProc(88, octstr:byte(60)-0x30)
	end
	local octstr = splist[89].val
	if type(octstr)=="string" then
	wk_SnmpProc(89 , octstr:byte(1 )-0x30)
	wk_SnmpProc(90 , octstr:byte(2 )-0x30)
	wk_SnmpProc(91 , octstr:byte(3 )-0x30)
	wk_SnmpProc(92 , octstr:byte(4 )-0x30)
	wk_SnmpProc(93 , octstr:byte(5 )-0x30)
	wk_SnmpProc(94 , octstr:byte(6 )-0x30)
	wk_SnmpProc(95 , octstr:byte(7 )-0x30)
	wk_SnmpProc(96 , octstr:byte(8 )-0x30)
	wk_SnmpProc(97 , octstr:byte(9 )-0x30)
	wk_SnmpProc(98 , octstr:byte(10)-0x30)
	wk_SnmpProc(99 , octstr:byte(11)-0x30)
	wk_SnmpProc(100, octstr:byte(12)-0x30)
	wk_SnmpProc(101, octstr:byte(13)-0x30)
	wk_SnmpProc(102, octstr:byte(14)-0x30)
	wk_SnmpProc(103, octstr:byte(15)-0x30)
	wk_SnmpProc(104, octstr:byte(16)-0x30)
	wk_SnmpProc(105, octstr:byte(17)-0x30)
	wk_SnmpProc(106, octstr:byte(18)-0x30)
	wk_SnmpProc(107, octstr:byte(19)-0x30)
	wk_SnmpProc(108, octstr:byte(20)-0x30)
	wk_SnmpProc(109, octstr:byte(21)-0x30)
	wk_SnmpProc(110, octstr:byte(22)-0x30)
	wk_SnmpProc(111, octstr:byte(23)-0x30)
	wk_SnmpProc(112, octstr:byte(24)-0x30)
	wk_SnmpProc(113, octstr:byte(25)-0x30)
	wk_SnmpProc(114, octstr:byte(26)-0x30)
	wk_SnmpProc(115, octstr:byte(27)-0x30)
	wk_SnmpProc(116, octstr:byte(28)-0x30)
	end
	local octstr = splist[117].val
	if type(octstr)=="string" then
	wk_SnmpProc(117, octstr:byte(1 )-0x30)
	wk_SnmpProc(118, octstr:byte(2 )-0x30)
	wk_SnmpProc(119, octstr:byte(3 )-0x30)
	wk_SnmpProc(120, octstr:byte(4 )-0x30)
	wk_SnmpProc(121, octstr:byte(5 )-0x30)
	wk_SnmpProc(122, octstr:byte(6 )-0x30)
	wk_SnmpProc(123, octstr:byte(7 )-0x30)
	wk_SnmpProc(124, octstr:byte(8 )-0x30)
	wk_SnmpProc(125, octstr:byte(9 )-0x30)
	wk_SnmpProc(126, octstr:byte(10)-0x30)
	wk_SnmpProc(127, octstr:byte(11)-0x30)
	wk_SnmpProc(128, octstr:byte(12)-0x30)
	wk_SnmpProc(129, octstr:byte(13)-0x30)
	wk_SnmpProc(130, octstr:byte(14)-0x30)
	wk_SnmpProc(131, octstr:byte(15)-0x30)
	wk_SnmpProc(132, octstr:byte(16)-0x30)
	wk_SnmpProc(133, octstr:byte(17)-0x30)
	wk_SnmpProc(134, octstr:byte(18)-0x30)
	wk_SnmpProc(135, octstr:byte(19)-0x30)
	wk_SnmpProc(136, octstr:byte(20)-0x30)
	wk_SnmpProc(137, octstr:byte(21)-0x30)
	wk_SnmpProc(138, octstr:byte(22)-0x30)
	wk_SnmpProc(139, octstr:byte(23)-0x30)
	wk_SnmpProc(140, octstr:byte(24)-0x30)
	wk_SnmpProc(141, octstr:byte(25)-0x30)
	wk_SnmpProc(142, octstr:byte(26)-0x30)
	wk_SnmpProc(143, octstr:byte(27)-0x30)
	wk_SnmpProc(144, octstr:byte(28)-0x30)
	end
end

local function PackQueryList(prio) --prio:0,normal 1,once
	local QueryTable = {}
	local n = 1
	for i=1,SPListLen do
		if splist[i].prio <= prio then
			QueryTable[n] = splist[i].spid
			n = n + 1
		end
	end
	
	local QueryLen = #QueryTable
	local querytimes = math.ceil(QueryLen/QueryOidNum)
	local begin = 1
	local querylist = {}
	for times=1,querytimes do
		local querysp={}
		local endpos = begin + QueryOidNum - 1
		endpos = endpos > QueryLen and QueryLen or endpos
		local k = 1
		for i=begin,endpos do
			querysp[k] = QueryTable[i]
			k = k + 1
		end
		table.insert(querylist,querysp)
		begin = begin + k - 1
	end
	return querylist
end

local function GetQueryList()
	local queryfrist = false
	local querylist_all = PackQueryList(1)
	local querylist_nor = PackQueryList(0)
	return function()
		if not queryfrist then
			queryfrist = true
			return querylist_all
		else
			return querylist_nor
		end
	end
end

--列出No Such Instance currently exists at this OID
--在第一轮query完成后执行
PollFrist=true
local function ListNoSuchOID(querylist)
	if PollFrist==true and connect == 1 then
		PollFrist = false
		for k,querysp in ipairs(querylist) do
			for i,spid in ipairs(querysp) do
				if splist[spid].val == nil then
				wk_Debug(3,sf("[err] spid=%d,showname=%s,oid=%s:No Such Instance currently exists at this OID",spid,splist[spid].showname,splist[spid].oid))
				end
			end
		end
	end
end

QuerySPList = GetQueryList()
local function QueryProc()
	local ProcFlag = false
	local querylist = QuerySPList()
	for t,querysp in ipairs(querylist) do
		local retbl = {}
		if QueryOidNum == 1 then
			local spid = querysp[1]
			local ret,val=wk_SnmpGet(splist[spid].oid)
			--wk_Debug(1,sf("spid=%d, ret=%s, val=%s",spid,tostring(ret),tostring(val)))
			if ret == 0 then
				splist[spid].proc = true
				retbl[spid] = val
			end
		else
			retbl = wk_PackQuery(querysp)
		end
		
		if retbl ~= nil then
			if connect==0 then
				connect = 1
				wk_ConnState(1)
			end
			
			for spid, val in pairs(retbl) do
				--wk_Debug(1,sf("spid=%d, val=%s",spid,val))
				splist[spid].proc = true
				splist[spid].val = val
			end
			ProcFlag = true
			QueryOK = QueryOK + 1
		else
			if connect==1 then
				connect=0
				wk_ConnState(0)
			end
			QueryFail = QueryFail + 1
		end
		if wk_RunState()~=1 then
			break
		end
	end
	
	ListNoSuchOID(querylist)
	
	if ProcFlag then
		wk_SnmpProcSP()  --全部分包取完后统一处理数据
	end
	PollCount = PollCount + 1
	wk_Debug(2,sf("Snmp Device:%s, connect:%d, QueryOK:%d, QueryFail:%d, PollCount:%d, RunErr:%d",Model,connect,QueryOK,QueryFail,PollCount,RunErr))
end

wk_Debug(2,sf("SNMP数据采集脚本线程启动：%s",Model))
wk_Debug(2,sf("SP总数量：%d，DIO：%d，AIO：%d，STR：%d，ENUM：%d",SPListLen,dcnt,acnt,scnt,ecnt))
wk_Debug(2,sf("每次取OID的数量：%d， 轮询间隔时间：%d秒，调试等级：%d",QueryOidNum,Interval,DebugLevel))
wk_Debug(2,sf("记录日志文件路径：%s",FileName))

Interval=Interval*10
time_count=Interval
while(true)
do
	--获取运行状态，如果没有下面这个判断，就无法停止这个设备线程，必须调用
	--同时也是软看门狗清零的地方
	runflag=wk_RunState()
	if (runflag ~= 1) then
		--wk_Info('thread quit ')
		wk_Debug(2,sf("SNMP数据采集脚本线程退出：%s",Model))
		break;
	end
	
	if (time_count > Interval) then --间隔5秒与设备通信一次
		time_count=0
		
		xpcall(QueryProc,exception)
		
		--将可能的cache发送到中心处理
		wk_SendCache()
	else
		wk_Sleep(100);
		time_count=time_count+1
	end
end

