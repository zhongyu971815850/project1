--���: Sechneider Smart-UPS RT 5000 XL SNMP
--MIB����powernet446.mib��
--��Ŀ��������Ŀ
--�ֳ���2023.06.05 ����
--˵����DIOΪV6֧�ֵ�ARRAY_CHAR_64_1���ͣ��ֳ�����V7������lua�ű���ʽ

Model = "Schneider UPS Symmetra"	--��ص��豸
MIB = "powernet446.mib"						--����汾-�Ӱ汾
Author = "mml"
DATE = "2023/6/5"
Ver = "SNMPLUA-V7-1.0"
Note = "ԭʼ���ݼ�sheet2"
QueryOidNum = 10		--ÿ��ȡOID������
Interval = 60				--��ѯ���,��
DebugLevel = 1			--0:���� 1:����¼������Ϣwk_Debug(3,...) 2:��¼�������Ҫ������Ϣ 3:��¼ȫ��������Ϣ				
LogPath = "D:/GNCV7/service/svrlog"	

--SP���˳��spid�����������sp���ͣ�oid��oid����
--����sp���ͱ����ǣ�"AIO", "DIO"�� "STR","ENUM" ֮һ
--oid������Ч���ǣ�OID_TYPE_INTEGER,OID_TYPE_ENUM,OID_TYPE_GAUGE,OID_TYPE_COUNTER,
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
--��������
--|spid|sptype|index|oid|oidtype|spname|showname|dodesc|d1desc|d0val|d1val|dwvalue|dwlevel|dwmsg|dwtype|dwvtime|ename|end0desc|end1desc|disable|control|save|priority|trap
{spid=0,sptype="DIO",index=0,oid="1.3.6.1.4.1.22853.1.2.1.2.1",spname="DI1",oidtype=2,showname="©ˮ���",d0desc="©ˮ",d1desc="����",d0val=0,d1val=1,dwvalue=0,dwlevel=2,dwmsg="©ˮ��",dwtype=1,dwvtime=15,ename="water lake",ed0desc="alarm",ed1desc="normal",disable=1,control=1,save=1,prio=1}, 
--������-���澯
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="©ˮ���",d0desc="©ˮ",d1desc="����",dwvalue=0,dwlevel=2}, 
--������
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="©ˮ���",d0desc="©ˮ",d1desc="����"},

--AIO
--��������
--|spid|sptype|index|oid|oidtype|spname|showname|ename|precision|unit|sendvar|ratio|sendinterval|awtype|awtime|enwarn1|hilimit1|lolimit1|hi_wmsg1|lo_wmsg1|enwarn2|hilimit2|lolimit2|hi_wmsg2|lo_wmsg2|enwarn3|hilimit3|lolimit3|hi_wmsg3|lo_wmsg3|disable|control|save|priority|trap
{spid=0,sptype="AIO",index=0,oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,spname="AI1",showname="A���ѹ", ename="voltage of phaseA",precision="0.0",unit="V",sendvar=2,ratio=1,protect=0.5,sendinterval=120,awtype=1,awtime=15,enwarn1=1,hilimit1=242,lolimit1=198,hi_wmsg1="hi1 msg",lo_wmsg1="lo1 msg",enwarn2=1,hilimit2=247,lolimit2=193,hi_wmsg2="hi2 msg", lo_wmsg2="lo1 msg",enwarn3=1,hilimit3=252,lolimit3=188,hi_wmsg3="hi3 msg", lo_wmsg3="lo3 msg",disable=1,control=1,save=1,prio=1},
--������
{sptype="AIO",oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,showname="A���ѹ", precision="0.0",unit="V",sendvar=2},


--STR
--��������
--|spid|sptype|index|oid|oidtype|spname|showname|ename|comptype|compwlevel|swtype|swtime|en_swarn1|s1wstr|s1wmsg|en_swarn2|s2wstr|s2wmsg|en_swarn3|s3wstr|s3wmsg|disable|control|save|priority|trap
{spid=0,sptype="STR",index=0,oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,spname="STR1",showname="IC����",ename="IC card",comptype=1,compwlevel=2,swtye=1,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--������
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC����",prio=1},


--ENUM
--|spid|sptype|index|oid|oidtype|spname|showname|ename|enumstr|en2umstr|comptype|compwlevel|ewtype|ewtime|en_ewarn1|e1wstr|e1wmsg|en_ewarn2|e2wstr|e2wmsg|en_ewarn3|e3wstr|e3wmsg|disable|control|save|priority|trap
{spid=0,sptype="ENUM",index=0,oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,spname="ENUM1",showname="�豸����״̬",ename="operate state",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����",en2umstr="0,stop\r\n1,standby\r\n2running\r\n3,fault",comptype=1,compwlevel=2,ewtype=1,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--������
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="�豸����״̬",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����"},
--]]

--prio��0:normal 1:once 2:never(һ��OID��Ӧ���SP,��������Ҫ�ر����)
--[[
{sptype="DIO",oid="1.3.6.1.4.1.22853.1.2.1.2.1",oidtype=2,showname="©ˮ���",d0desc="©ˮ",d1desc="����",dwvalue=1,dwlevel=2,dwmsg="©ˮ��",dwtype=1,dwvtime=15,disable=1,control=1,save=1,prio=1}, 
{sptype="AIO",oid="1.3.6.1.4.1.22853.1.3.1.2.1",oidtype=1,showname="A���ѹ",precision="0.0",unit="V",sendvar=2,protect=0.5,sendinterval=120,awtype=1,awtime=15,enwarn1=1,hilimit1=242,lolimit1=198,hi_wmsg1="hi1 msg",lo_wmsg1="lo1 msg",enwarn2=1,hilimit2=247,lolimit2=193,hi_wmsg2="hi2 msg", lo_wmsg2="lo1 msg",enwarn3=1,hilimit3=252,lolimit3=188,hi_wmsg3="hi3 msg", lo_wmsg3="lo3 msg",disable=1,control=1,save=1,prio=1},
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC����",comptype=0,compwlevel=2,swtype=0,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="STR",oid="1.3.6.1.4.1.22853.1.4.1.2.1",oidtype=1,showname="IC����2",comptype=1,compwlevel=2,swtype=1,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="�豸����״̬",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����",comptype=0,compwlevel=2,ewtype=0,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
{sptype="ENUM",oid="1.3.6.1.4.1.22853.1.5.1.2.1",oidtype=2,showname="�豸����״̬",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����",comptype=1,compwlevel=2,ewtype=1,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--]]

splist={
--[[1 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.1.1.1.0",oidtype=1,showname="UPS�ͺ�",prio=1},
--[[2 ]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.2.1.1.0",oidtype=2,showname="���״̬",en2umstr="1,unknown\r\n2,batteryNormal\r\n3,batteryLow\r\n4,batteryInFaultCondition\r\n5,noBatteryPresent",enumstr="1,δ֪\r\n2,�������\r\n3,�͵���\r\n4,����\r\n5,δ����"},
--[[3 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.1.2.0",oidtype=8,showname="��طŵ�ʱ��"},
--[[4 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.1.3.0",oidtype=1,showname="����ϴθ�������",prio=1},
--[[5 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.1.0",oidtype=4,showname="���ʣ�����",unit="%"},
--[[6 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.2.0",oidtype=4,showname="����¶�",unit="��"},
--[[7 ]]{sptype="STR",oid=".1.3.6.1.4.1.318.1.1.1.2.2.3.0",oidtype=8,showname="���ʣ��ʱ��"},
--[[8 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.4.0",oidtype=2,showname="��������"},
--[[9 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.5.0",oidtype=2,showname="���õ������",prio=1},
--[[10]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.6.0",oidtype=2,showname="���ϵ������"},
--[[11]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.8.0",oidtype=2,showname="��ص�ѹ",unit="V"},
--[[12]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.9.0",oidtype=2,showname="��ص���",unit="A"},
--[[13]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.2.2.10.0",oidtype=2,showname="ֱ��ĸ�ߵ���",unit="A"},
--[[14]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.1.1.0",oidtype=2,showname="��������",prio=1},
--[[15]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.1.0",oidtype=4,showname="�����ѹ",unit="V"},
--[[16]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.2.0",oidtype=4,showname="��������ѹ",unit="V"},
--[[17]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.3.0",oidtype=4,showname="������С��ѹ",unit="V"},
--[[18]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.3.2.4.0",oidtype=4,showname="����Ƶ��",unit="Hz"},
--[[19]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.3.2.5.0",oidtype=2,showname="�����л�ԭ��",en2umstr="1,noTransfer\r\n2,highLineVoltage\r\n3,brownout\r\n4,blackout\r\n5,smallMomentarySag\r\n6,deepMomentarySag\r\n7,smallMomentarySpike\r\n8,largeMomentarySpike\r\n9,selfTest\r\n10,rateOfVoltageChange",enumstr="1,���л�\r\n2,��ѹ����\r\n3,�����͵�ѹ\r\n4,ͣ��\r\n5,��ȵ�ѹ����\r\n6,��ȵ�ѹ����\r\n7,��ȸߵ�ѹ����\r\n8,��ȸߵ�ѹ����\r\n9,�Բ���\r\n10,��ѹ�仯��"},
--[[20]]{sptype="ENUM",oid=".1.3.6.1.4.1.318.1.1.1.4.1.1.0",oidtype=2,showname="UPS����ģʽ",en2umstr="1,unknown\r\n2,onLine\r\n3,onBattery\r\n4,onSmartBoost\r\n5,timedSleeping\r\n6,softwareBypass\r\n7,off\r\n8,rebooting\r\n9,switchedBypass\r\n10,hardwareFailureBypass\r\n11,sleepingUntilPowerReturn\r\n12,onSmartTrim\r\n13,ecoMode\r\n14,hotStandby\r\n15,onBatteryTest\r\n16,emergencyStaticBypass\r\n17,staticBypassStandby\r\n18,powerSavingMode\r\n19,spotMode\r\n20,eConversion\r\n21,chargerSpotmode\r\n22,inverterSpotmode\r\n23,activeLoad\r\n24,batteryDischargeSpotmode\r\n25,inverterStandby\r\n26,chargerOnly\r\n27,distributedEnergyReserve\r\n28,selfTest",enumstr="1,δ֪\r\n2,����\r\n3,���\r\n4,��ѹ\r\n5,��ʱ����\r\n6,����·\r\n7,�ر�\r\n8,����\r\n9,����·\r\n10,Ӳ������ת��·\r\n11,�����������ָ�\r\n12,ն��\r\n13,ECO\r\n14,����\r\n15,��ز���\r\n16,������̬��·\r\n17,��̬��·����\r\n18,����ģʽ\r\n19,ͣ��\r\n20,ת��ģʽ\r\n21,�����ͣ��\r\n22,���ͣ��\r\n23,�й�����\r\n24,��طŵ���ֹ\r\n25,������\r\n26,�����\r\n27,�ֲ�ʽ��Դ����\r\n28,�Բ���"},
--[[21]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.1.2.0",oidtype=2,showname="�������"},
--[[22 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.1.0",oidtype=4,showname="�����ѹ",unit="V"},
--[[23 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.2.0",oidtype=4,showname="���Ƶ��",unit="Hz"},
--[[24 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.3.0",oidtype=4,showname="������ذٷֱ�",unit="%"},
--[[25 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.4.0",oidtype=4,showname="�������",unit="A"},
--[[26 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.5.0",oidtype=4,prio=2,showname="���ඪʧ����"},
--[[27 ]]{sptype="AIO",oid=".1.3.6.1.4.1.318.1.1.1.4.2.6.0",oidtype=2,prio=2,showname="����������",unit="KVA",prio=1},
--[[28 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.8.1.0",oidtype=2,showname="ͨ��״̬",d0desc="����",d1desc="�Ͽ�",d0val=1,d1val=2,dwvalue=2,dwlevel=1},
--[[29 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=0,showname="UPS�쳣״̬�澯",d0desc="����",d1desc="�쳣",dwvalue=1,dwlevel=2},
--[[30 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ع���״̬",d0desc="�ǵ�ع���",d1desc="��ع���",dwvalue=1,dwlevel=2},
--[[31 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ص͵���",d0desc="����",d1desc="������",dwvalue=1,dwlevel=2},
--[[32 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS����",d0desc="������",d1desc="����"},
--[[33 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��������",d0desc="����Ҫ",d1desc="���������",dwvalue=1,dwlevel=2},
--[[34 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ͨ�Ž���",d0desc="δ����",d1desc="����"},
--[[35 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�Զ���ѹ����",d0desc="��",d1desc="��"},
--[[36 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�Զ���ѹ����",d0desc="��",d1desc="��"},
--[[37 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���ظ澯",d0desc="δ����",d1desc="����",dwvalue=1,dwlevel=2},
--[[38 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ʱ��У׼",d0desc="δУ׼",d1desc="��У׼"},
--[[39 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��طŵ�",d0desc="�Ƿŵ�״̬",d1desc="�ŵ�״̬"},
--[[40 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ֶ���·״̬",d0desc="���ֶ���·״̬",d1desc="�ֶ���·״̬",dwvalue=1,dwlevel=2},
--[[41 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����·״̬",d0desc="�������·״̬",d1desc="�����·״̬",dwvalue=1,dwlevel=2},
--[[42 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ڲ�����ת��·",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[43 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��Դ����ת��·",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[44 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ȹ���ת��·",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[45 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ʱ����״̬",d0desc="��",d1desc="��"},
--[[46 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�������е�ָ�",d0desc="��",d1desc="��"},
--[[47 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS����",d0desc="��",d1desc="��"},
--[[48 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��������",d0desc="������״̬",d1desc="������"},
--[[49 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���ͨ�Ŷ�ʧ",d0desc="δ��ʧ",d1desc="��ʧ",dwvalue=1,dwlevel=2},
--[[50 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���������ػ�",d0desc="δ����",d1desc="�����ػ���ʼ"},
--[[51 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="������ѹ��ѹ����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[52 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�����ѹ�쳣",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[53 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��س��������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[54 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����¶�ƫ��",d0desc="����",d1desc="����¶�ƫ��",dwvalue=1,dwlevel=1},
--[[55 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ظ��¸澯",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[56 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ظ������ظ澯",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=3},
--[[57 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�����Լ�",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[58 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ص����ͻ��ع���",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[59 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�����豸�����������ػ�",d0desc="��",d1desc="��"},
--[[60 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�����豸�����������ػ�",d0desc="��",d1desc="��"},
--[[61 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���δ����",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[62 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ִ��ͬ������",d0desc="��",d1desc="��"},
--[[63 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ִ��ͬ������������",d0desc="��",d1desc="��"},
--[[64 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ִ��ͬ������������",d0desc="��",d1desc="��"},
--[[65 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���ֱ����ƽ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[66 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�л��̵�������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[67 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ػ����޷��л�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[68 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ص����͹ػ�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[69 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�����豸���ȹ���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[70 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���̵�������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[71 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��·�̵�������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[72 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ʱ��·״̬",d0desc="��",d1desc="��",dwvalue=1,dwlevel=2},
--[[73 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ڲ��¶ȹ���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[74 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����¶ȴ���������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[75 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��·���볬��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[76 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="ֱ��ĸ�߹�ѹ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[77 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="PFC����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[78 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="Ӳ�����ع���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=3},
--[[79 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��ɫģʽ��ECOģʽ",d0desc="��",d1desc="��"},
--[[80 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="�ȱ�״̬",d0desc="��",d1desc="��"},
--[[81 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="����ͣ��(EPO)",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=3},
--[[82 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="���ر���Υ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[83 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��·��λ����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[84 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS�ڲ�ͨ�Ź���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[85 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��Ч��ѹģʽ",d0desc="��",d1desc="��"},
--[[86 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS�ػ�",d0desc="��",d1desc="��"},
--[[87 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="UPS����",d0desc="��",d1desc="��"},
--[[88 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.1.1.0",oidtype=1,prio=2,showname="��΢�򻷾�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=1},
--[[89 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=0,showname="��Դģ�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[90 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="������ģ�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[91 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��������ģ�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[92 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��ع���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[93 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="����(kVA)������ֵΥ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[94 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="���ඪʧ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[95 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="������ڱ�����ֵ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[96 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��·Ƶ�ʻ��ѹ����Χ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[97 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��·�Ӵ���������·״̬",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[98 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��·�Ӵ�����������״̬",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[99 ]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="���ڲ����ϴ�����·",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[100]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="���ش�����·",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[101]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="����ά����·״̬",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[102]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="�����·���豸��բ��·",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[103]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="ϵͳ�����ȹ���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[104]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��������ģ���ڱ�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[105]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="IICģ���ͨ�Ź���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[106]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="�޹�����Դģ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[107]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="���عػ�����·;����Ƶ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[108]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="����ʱ���ڱ�����ֵ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[109]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��չ֡���й���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[110]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="�����ѹ������Χ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[111]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="UPS��ͬ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[112]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="û�а�װ���",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[113]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��ص�ѹ��",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[114]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="��⵽UPSĳ������",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[115]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="�ֳ���·����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[116]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.1.0",oidtype=1,prio=2,showname="���籣���̵�����·",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[117]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=0,showname="�ⲿ��ѹ������ ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[118]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="�ⲿ�����豸���� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[119]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="�ⲿֱ����·����բ ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[120]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="ϵͳ��Դ���� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[121]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="��ؼ�ؿ�����",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[122]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="��ؼ�ؿ����Ƴ�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[123]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="XRͨ�ſ����� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[124]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="XRͨ�ſ����Ƴ�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[125]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="�ⲿ�����豸��ؿ����� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[126]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="�ⲿ�����豸��ؿ���ɾ�� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[127]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="�ڲ�ֱ����·����բ ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[128]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="��̬��·���ع��� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[129]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="ϵͳEEPROM���Ƴ�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[130]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="ϵͳ��EEPROM���� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[131]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="UPS��ǿ����· ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[132]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="��̬��·����ģ�鱻�Ƴ� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[133]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="ϵͳ�������ù��� ",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
--[[134]]{sptype="DIO",oid=".1.3.6.1.4.1.318.1.1.1.11.2.2.0",oidtype=1,prio=2,showname="��س�����ⲿ�ػ�",d0desc="����",d1desc="�澯",dwvalue=1,dwlevel=2},
}

SPListLen = #splist
dcnt,acnt,scnt,ecnt=0,0,0,0
local function Init()
  --ע��SP��
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
			--DIO �ű����õ������ã��������ʼ��
			spitem.d0val = spitem.d0val or 0
			spitem.d1val = spitem.d1val or 1
		elseif sptype == "AIO" then
			acnt = acnt + 1
			spitem.index = acnt
			--AIO �ű����õ������ã��������ʼ��
			spitem.ratio = spitem.ratio or 1
		elseif sptype == "STR" then
			scnt = scnt + 1
			spitem.index = scnt
			--STR �ű����õ������ã��������ʼ��
		else
			ecnt = ecnt + 1
			spitem.index = ecnt
			--ENUM �ű����õ������ã��������ʼ��
		end
		
		--�ű����õ������ã��������ʼ�������ܺ�ConfigSP����һ�𣬷���ű��ǵ�һ������ʱ�ⲿ�ֱ����޷���ʼ��
		--ͨ������
		spitem.proc = spitem.proc or false
		spitem.prio = spitem.prio or 0
		--spitem.trap = spitem.trap or 0
		--spitem.control ���ƿ��ܽű��л��õ�
		
		--�����ݲ�֧��ע���oidtype��ע��ʱ���ƹ�ȥ���Ϳ��Բ�Ӱ����������ʹ���
		--ret=wk_RegistSP(spitem.spid,spitem.index,spitem.sptype,spitem.oid,OID_TYPE[spitem.oidtype==11 and 1 or spitem.oidtype])
		ret=wk_RegistSP(spitem.spid,spitem.index,spitem.sptype,spitem.oid,OID_TYPE[spitem.oidtype])
		--wk_Debug(2,string.format("spid=%d,index=%d,sptype=%s,showname=%s",spitem.spid,spitem.index,spitem.sptype,spitem.showname))
		if ret==0 then --����ӵĵ㣬���ó�ʼ����ֵ
			if Language==0 then --����
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
			
			--ͨ������
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

connect=0 --����״̬
QueryOK=0
QueryFail=0
PollCount=0
RunErr=0
local function exception(err)
	RunErr = RunErr + 1
	wk_Debug(3,err)
end

--ת���������ַ���Ϊ16���ƴ�ӡ��ʽ
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
	--return sf("%d��%dСʱ%d����%d��",day,hour,minute,left)
	local sday = day > 0 and sf("%d��",day) or ""
	local shour= hour > 0 and sf("%dСʱ",hour) or ""
	local smin = minute > 0 and sf("%d����",minute) or ""
	local ssec = sf("%d��",left)
	return sday..shour..smin..ssec
end
			
local function Snmp_DateTime(val)
	return #val>7 and sf("%04d-%02d-%02d %02d:%02d:%02d",string.unpack(">H",val),val:byte(3),val:byte(4),val:byte(5),val:byte(6),val:byte(7)) or val
end

local function Snmp_IPAddress(val)
	return #val==4 and sf("%d.%d.%d.%d",val:byte(1),val:byte(2),val:byte(3),val:byte(4)) or val
end

local function Snmp_PHYSAddress(val)
	--softloopback��macΪ��
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
		if splist[spid].oidtype == 8 then  --TIMETICKSת��Ϊ xx��xxʱxx��xx��
			val = Snmp_TimeTicks(val)
		end
		if splist[spid].oidtype == 9 then  --DATETIMEת��Ϊ2022-03-08 17:03:21
			val = Snmp_DateTime(val)
		end
		if splist[spid].oidtype == 10 then  --IP_ADDRESSת��Ϊ127.0.0.1
			val = Snmp_IPAddress(val)
		end
		if splist[spid].oidtype == 11 then  --PHYS_ADDRESSת��Ϊ50-E5-49-57-96-F9
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
	--ȫ��proc
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

--�г�No Such Instance currently exists at this OID
--�ڵ�һ��query��ɺ�ִ��
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
		wk_SnmpProcSP()  --ȫ���ְ�ȡ���ͳһ��������
	end
	PollCount = PollCount + 1
	wk_Debug(2,sf("Snmp Device:%s, connect:%d, QueryOK:%d, QueryFail:%d, PollCount:%d, RunErr:%d",Model,connect,QueryOK,QueryFail,PollCount,RunErr))
end

wk_Debug(2,sf("SNMP���ݲɼ��ű��߳�������%s",Model))
wk_Debug(2,sf("SP��������%d��DIO��%d��AIO��%d��STR��%d��ENUM��%d",SPListLen,dcnt,acnt,scnt,ecnt))
wk_Debug(2,sf("ÿ��ȡOID��������%d�� ��ѯ���ʱ�䣺%d�룬���Եȼ���%d",QueryOidNum,Interval,DebugLevel))
wk_Debug(2,sf("��¼��־�ļ�·����%s",FileName))

Interval=Interval*10
time_count=Interval
while(true)
do
	--��ȡ����״̬�����û����������жϣ����޷�ֹͣ����豸�̣߳��������
	--ͬʱҲ�����Ź�����ĵط�
	runflag=wk_RunState()
	if (runflag ~= 1) then
		--wk_Info('thread quit ')
		wk_Debug(2,sf("SNMP���ݲɼ��ű��߳��˳���%s",Model))
		break;
	end
	
	if (time_count > Interval) then --���5�����豸ͨ��һ��
		time_count=0
		
		xpcall(QueryProc,exception)
		
		--�����ܵ�cache���͵����Ĵ���
		wk_SendCache()
	else
		wk_Sleep(100);
		time_count=time_count+1
	end
end

