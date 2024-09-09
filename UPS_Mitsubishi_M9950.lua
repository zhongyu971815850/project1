--���: ���� Mitsubishi M9950 UPS Modbus Tcp 
--Э�飺ͨ�Ż�����ָ����.pdf
--��Ŀ��2023\5.17 ������ĿSNMP����V7
--�ֳ���Ҷ���
--˵����

--�ļ��汾��1.0
--�޸���ʷ��

--�豸�̵߳�Lua�ű���Դ
local devcfg = wk_GetDevConfig() or {}

TimeoutMillSec=devcfg.TimeoutMillSec or 2000
PollInterval=devcfg.PollInterval or 200
RetryNum=devcfg.RetryTimes or 1
DebugFlag=devcfg.DebugFlag or false

assert(TimeoutMillSec>0)
assert(PollInterval>0)
assert(RetryNum>=0)

local sf=string.format
local function wk_GetDeviceInfo()
	if devcfg.COMMTYPE=="ModbusTCP" then
		return sf("%s(%s)",devcfg.SUNAME,devcfg.HOSTIP)
	elseif devcfg.COMMTYPE=="SerialCOM" then
		return sf("%s(%s)",devcfg.SUNAME,devcfg.SERIALCOM)
	elseif devcfg.COMMTYPE=="GNCGateway" then
		return sf("%s(%s,%s)",devcfg.SUNAME,devcfg.GNCGATEWAY,devcfg.SERIALPORT)
	else
		return "" --devcfg.SSID devcfg.SUID
	end
end

local devInfo=wk_GetDeviceInfo()

--level 1:��Ҫ��Ϣ�������Ϣ(lua���г���)
--level 2:��Ҫ������Ϣ(�ű�����ֹͣ����Ϣ)
--level 3:������Ϣ(ͨ������)
--����ģʽ������������debug��Ϣ����̨������Ϣ
--�ű��༭���Խ׶Σ������������У���ʱʹ��print()
local function wk_Debug(level,str)
	local msg=devInfo.." "..str
	if DebugFlag and level>2 then
		wk_Info(msg)
	end
	wk_Log(level,msg)
end

local function wk_Run()
	return (wk_RunState()==1) and true or false
end

--������¼��log������һЩ��������ĵ��Լ�¼
--����������Զ�ɾ����gncmodbussvr_��ͷ�Ĺ���log
local LogPath="D:/GNCV7/service/svrlog"
local function Log(str)
	local tm = os.date("*t",os.time())
	--local filename = string.format("D:\\GNCV7\\service\\svrlog\\gncsnmpscript_%04d%02d%02d.log",tm.year,tm.month,tm.day)
	local filename = sf("%s/gncmodbussvr_%s_%04d%02d%02d.log",LogPath,devInfo,tm.year,tm.month,tm.day)
	local file = io.open(filename, "a")
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

--�ⲿ��log�����Զ�ɾ�������ļ��������ʹ��
local function LogPersistence(str)
	local tm = os.date("*t",os.time())
	--local filename = string.format("D:\\GNCV7\\service\\svrlog\\gncsnmpscript_%04d%02d%02d.log",tm.year,tm.month,tm.day)
	local filename = sf("%s/modbus_%s_%04d%02d%02d.log",LogPath,devInfo,tm.year,tm.month,tm.day)
	local file = io.open(filename, "a")
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

--[[
--DIO
--��������
--|spid|sptype|index|spname|showname|dodesc|d1desc|d0val|d1val|dwvalue|dwlevel|dwmsg|dwtype|dwvtime|ename|end0desc|end1desc|disable|control|save|getonce
{spid=0,sptype="DIO",index=0,spname="DI1",showname="©ˮ���",d0desc="©ˮ",d1desc="����",d0val=0,d1val=1,dwvalue=0,dwlevel=2,dwmsg="©ˮ��",dwtype=1,dwvtime=15,ename="water lake",ed0desc="alarm",ed1desc="normal",disable=1,control=1,save=1,once=1}, 
--������-���澯
{sptype="DIO",showname="©ˮ���",d0desc="©ˮ",d1desc="����",dwvalue=0,dwlevel=2}, 
--������
{sptype="DIO",showname="©ˮ���",d0desc="©ˮ",d1desc="����"},

--AIO
--��������
--|spid|sptype|index|spname|showname|ename|precision|unit|sendvar|ratio|sendinterval|awtype|awtime|enwarn1|hilimit1|lolimit1|hi_wmsg1|lo_wmsg1|enwarn2|hilimit2|lolimit2|hi_wmsg2|lo_wmsg2|enwarn3|hilimit3|lolimit3|hi_wmsg3|lo_wmsg3|disable|control|save|once
{spid=0,sptype="AIO",index=0,spname="AI1",showname="A���ѹ", ename="voltage of phaseA",precision="0.0",unit="V",sendvar=2,ratio=1,protect=0.5,sendinterval=120,awtype=1,awtime=15,enwarn1=1,hilimit1=242,lolimit1=198,hi_wmsg1="hi1 msg",lo_wmsg1="lo1 msg",enwarn2=1,hilimit2=247,lolimit2=193,hi_wmsg2="hi2 msg", lo_wmsg2="lo1 msg",enwarn3=1,hilimit3=252,lolimit3=188,hi_wmsg3="hi3 msg", lo_wmsg3="lo3 msg",disable=1,control=1,save=1,once=1},
--������
{sptype="AIO",showname="A���ѹ", precision="0.0",unit="V",sendvar=2},


--STR
--��������
--|spid|sptype|index|spname|showname|ename|comptype|compwlevel|swtype|swtime|en_swarn1|s1wstr|s1wmsg|en_swarn2|s2wstr|s2wmsg|en_swarn3|s3wstr|s3wmsg|disable|control|save|once
{spid=0,sptype="STR",index=0,spname="STR1",showname="IC����",ename="IC card",comptype=1,compwlevel=2,swtye=1,swtime=15,en_swarn1=1,s1wstr="w1-1\r\nw1-2",s1wmsg="s1 msg",en_swarn2=1,s2wstr="w2-1\r\nw2-2",s2wmsg="s2 msg",en_swarn3=1,s3wstr="w3-1\r\nw3-2",s3wmsg="s3 msg",disable=1,control=1,save=1,once=1},
--������
{sptype="STR",showname="IC����",prio=1},


--ENUM
--|spid|sptype|index|spname|showname|ename|enumstr|en2umstr|comptype|compwlevel|ewtype|ewtime|en_ewarn1|e1wstr|e1wmsg|en_ewarn2|e2wstr|e2wmsg|en_ewarn3|e3wstr|e3wmsg|disable|control|save|once
{spid=0,sptype="ENUM",index=0,spname="ENUM1",showname="�豸����״̬",ename="operate state",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����",en2umstr="0,stop\r\n1,standby\r\n2running\r\n3,fault",comptype=1,compwlevel=2,ewtype=1,ewtime=15,en_ewarn1=1,e1wstr="0\r\n1",e1wmsg="s1 msg",en_ewarn2=1,e2wstr="2\r\n",e2wmsg="s2 msg",en_ewarn3=1,e3wstr="3",e3wmsg="s3 msg",disable=1,control=1,save=1,prio=1},
--������
{sptype="ENUM",showname="�豸����״̬",enumstr="0,ֹͣ\r\n1,����\r\n2����\r\n3,����"},
--]]

splist={
--[[]]--[[]]--[[1]]{sptype="DIO",showname="��UPSͨ��״̬",d0desc="�Ͽ�",d1desc="����",dwvalue=0,dwlevel=1},
--[[300087]]--[[0056]]--[[2]]{sptype="DIO",showname="UPSͨ��",d0desc="�쳣",d1desc="����",dwvalue=0,dwlevel=1},
--[[300088]]--[[0057]]--[[3]]{sptype="ENUM",showname="��ص���",enumstr="0,����\r\n1,�͵���\r\n2,�ľ�"},
--[[300089]]--[[0058]]--[[4]]{sptype="ENUM",showname="��س��״̬",enumstr="0,����\r\n1,����\r\n2,ֹͣ\r\n3,�ŵ�"},
--[[300090]]--[[0059]]--[[5]]{sptype="AIO",showname="���������ʱ��",precision="0",unit="s",minval=0,maxval=99999},
--[[300091]]--[[005A]]--[[6]]{sptype="AIO",showname="���Ԥ��ʣ��ʱ��",precision="0",unit="min",minval=0,maxval=99999},
--[[300092]]--[[005B]]--[[7]]{sptype="AIO",showname="���ʣ�����",precision="0.0",unit="%",minval=0,maxval=100},
--[[300093]]--[[005C]]--[[8]]{sptype="AIO",showname="��ص�ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300094]]--[[005D]]--[[9]]{sptype="AIO",showname="��ص���",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300095]]--[[005E]]--[[10]]{sptype="AIO",showname="����¶�",precision="0.0",unit="��",minval=-20,maxval=120},
--[[300096]]--[[005F]]--[[11]]{sptype="AIO",showname="������·��ʷ���ϴ���",precision="0",unit="��",minval=0,maxval=200},
--[[300097]]--[[0060]]--[[12]]{sptype="AIO",showname="��������",precision="0",unit="",minval=0,maxval=3},
--[[300098]]--[[0061]]--[[13]]{sptype="AIO",showname="����Ƶ��",precision="0.0",unit="Hz",minval=0,maxval=100},
--[[300099]]--[[0062]]--[[14]]{sptype="AIO",showname="����A���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300100]]--[[0063]]--[[15]]{sptype="AIO",showname="����A�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300101]]--[[0064]]--[[16]]{sptype="AIO",showname="����A����Ч����",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300102]]--[[0065]]--[[17]]{sptype="AIO",showname="����B���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300103]]--[[0066]]--[[18]]{sptype="AIO",showname="����B�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300104]]--[[0067]]--[[19]]{sptype="AIO",showname="����B����Ч����",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300105]]--[[0068]]--[[20]]{sptype="AIO",showname="����C���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300106]]--[[0069]]--[[21]]{sptype="AIO",showname="����C�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300107]]--[[006A]]--[[22]]{sptype="AIO",showname="����C����Ч����",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300108]]--[[006B]]--[[23]]{sptype="ENUM",showname="���Դ",enumstr="0,�����\r\n1,���\r\n2,��·\r\n5,����"},
--[[300109]]--[[006C]]--[[24]]{sptype="AIO",showname="���Ƶ��",precision="0.0",unit="Hz",minval=0,maxval=100},
--[[300110]]--[[006D]]--[[25]]{sptype="AIO",showname="�������",precision="0",unit="",minval=0,maxval=3},
--[[300111]]--[[006E]]--[[26]]{sptype="AIO",showname="���A���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300112]]--[[006F]]--[[27]]{sptype="AIO",showname="���A�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300113]]--[[0070]]--[[28]]{sptype="AIO",showname="���A�๦��",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300114]]--[[0071]]--[[29]]{sptype="AIO",showname="���A�ฺ�ذٷֱ�",precision="0.0",unit="%",minval=0,maxval=100},
--[[300115]]--[[0072]]--[[30]]{sptype="AIO",showname="���B���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300116]]--[[0073]]--[[31]]{sptype="AIO",showname="���B�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300118]]--[[0075]]--[[32]]{sptype="AIO",showname="���B�ฺ�ذٷֱ�",precision="0.0",unit="%",minval=0,maxval=100},
--[[300119]]--[[0076]]--[[33]]{sptype="AIO",showname="���C���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300120]]--[[0077]]--[[34]]{sptype="AIO",showname="���C�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300121]]--[[0078]]--[[35]]{sptype="AIO",showname="���C�๦��",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300122]]--[[0079]]--[[36]]{sptype="AIO",showname="���C�ฺ�ذٷֱ�",precision="0.0",unit="%",minval=0,maxval=100},
--[[300117]]--[[0074]]--[[37]]{sptype="ENUM",showname="ͬ��״̬",enumstr="0,������ر�\r\n1,ͬ��\r\n2,�첽"},
--[[300123]]--[[007A]]--[[38]]{sptype="AIO",showname="�����ѹUN",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300124]]--[[007B]]--[[39]]{sptype="AIO",showname="�����ѹVN",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300125]]--[[007C]]--[[40]]{sptype="AIO",showname="�����ѹWN",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300126]]--[[007D]]--[[41]]{sptype="AIO",showname="�������",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300127]]--[[007E]]--[[42]]{sptype="AIO",showname="���ع�������",precision="0.0",unit="",minval=0,maxval=100},
--[[300128]]--[[007F]]--[[43]]{sptype="AIO",showname="��·Ƶ��",precision="0.0",unit="Hz",minval=0,maxval=9999},
--[[300129]]--[[0080]]--[[44]]{sptype="AIO",showname="��·����",precision="0",unit="",minval=0,maxval=3},
--[[300130]]--[[0081]]--[[45]]{sptype="AIO",showname="��·A���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300131]]--[[0082]]--[[46]]{sptype="AIO",showname="��·A�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300132]]--[[0083]]--[[47]]{sptype="AIO",showname="��·A�๦��",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300133]]--[[0084]]--[[48]]{sptype="AIO",showname="��·B���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300134]]--[[0085]]--[[49]]{sptype="AIO",showname="��·B�๦��",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300135]]--[[0086]]--[[50]]{sptype="AIO",showname="��·B���Դ",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300136]]--[[0087]]--[[51]]{sptype="AIO",showname="��·C���ѹ",precision="0.0",unit="V",minval=-200,maxval=500},
--[[300137]]--[[0088]]--[[52]]{sptype="AIO",showname="��·C�����",precision="0.0",unit="A",minval=-200,maxval=500},
--[[300138]]--[[0089]]--[[53]]{sptype="AIO",showname="��·C�๦��",precision="0.0",unit="kW",minval=0,maxval=9999},
--[[300158]]--[[009D]]--[[54]]{sptype="AIO",showname="��ǰ�澯����",precision="0",unit="",minval=0,maxval=10,enwarn2=1,hilimit2=0.5},
--[[300159]]--[[009E]]--[[55]]{sptype="STR",showname="��ǰ�澯��Ŀ1",prio=1,comptype=1,compwlevel = 2},
--[[300160]]--[[009F]]--[[56]]{sptype="STR",showname="��ǰ�澯��Ŀ2",prio=1,comptype=1,compwlevel = 2},
--[[300161]]--[[00A0]]--[[57]]{sptype="STR",showname="��ǰ�澯��Ŀ3",prio=1,comptype=1,compwlevel = 2},
--[[300162]]--[[00A1]]--[[58]]{sptype="STR",showname="��ǰ�澯��Ŀ4",prio=1,comptype=1,compwlevel = 2},
--[[300163]]--[[00A2]]--[[59]]{sptype="STR",showname="��ǰ�澯��Ŀ5",prio=1,comptype=1,compwlevel = 2},
--[[300164]]--[[00A3]]--[[60]]{sptype="STR",showname="��ǰ�澯��Ŀ6",prio=1,comptype=1,compwlevel = 2},
--[[300165]]--[[00A4]]--[[61]]{sptype="STR",showname="��ǰ�澯��Ŀ7",prio=1,comptype=1,compwlevel = 2},
--[[300166]]--[[00A5]]--[[62]]{sptype="STR",showname="��ǰ�澯��Ŀ8",prio=1,comptype=1,compwlevel = 2},
--[[300167]]--[[00A6]]--[[63]]{sptype="STR",showname="��ǰ�澯��Ŀ9",prio=1,comptype=1,compwlevel = 2},
--[[300168]]--[[00A7]]--[[64]]{sptype="STR",showname="��ǰ�澯��Ŀ10",prio=1,comptype=1,compwlevel = 2},
}

alarmFlag = {
	[0] = "",
	[2] =   "[UF001]�����·�쳣",
	[4] =   "[UF002]������������",
	[6] =   "[UF003]�������쳣(Ԥ���쳣)",
	[8] =   "[UF006]�������쳣",
	[10] =  "[UF011]�Ӵ���52RC(CB1)�쳣(�ϴ�ƫ���ʵ���ź�)",
	[12] =  "[UF052]�Ӵ���52RC(CB1)�쳣(Сƫ���ʵ���ź�)",
	[14] =  "[UF055]�������쳣",
	[16] =  "[UF056]������������",
	[18] =  "[UF059]�����·�쳣",
	[20] =  "[UF102]ֱ������ѹ",
	[22] =  "[UF103]ֱ���͵�ѹ",
	[24] =  "[UF108]ն����������",
	[26] =  "[UF109]ֱ�������ݵ�ѹ��ƽ�� ",
	[28] =  "[UF110]����λ����",
	[30] =  "[UF111]UPS���ƻ�·����(IDƽ���쳣)",
	[32] =  "[UF112]ֱ����·�쳣",
	[34] =  "[UF128]���Ƶ�Դ�쳣",
	[36] =  "[UF119]ֱ���ӵض�·",
	[38] =  "[UF159]ֱ���ӵض�·",
	[42] =  "[UF151]ֱ����ѹ�쳣",
	[44] =  "[UF152]ֱ����ѹ�쳣",
	[48] =  "[UF154]��·��72B(CB2)�쳣(��ѹʱ72B�պ�)",
	[50] =  "[UF156]���ֹͣ(��ع���)",
	[52] =  "[UF157]��ع���",
	[54] =  "[UF158]���Һ�����",
	[56] =  "[UF160]UPS���ƻ�·����(�����������쳣)",
	[58] =  "[UF161]���ֹͣ(ֱ����ѹ�쳣)",
	[60] =  "[UF162]����쳣",
	[62] =  "[UF163]������ѹ�쳣",
	[64] =  "[UF170]VDB�������쳣",
	[72] =  "[UF201]���������ѹ",
	[74] =  "[UF202]�����Ƿѹ",
	[76] =  "[UF203]�����������",
	[78] =  "[UF204]�����·�쳣",
	[80] =  "[UF206]UPS���ƻ�·����(���ⲿѹ��)",
	[82] =  "[UF207]����λ����",
	[84] =  "[UF208]UPS���ƻ�·����(��������)",
	[86] =  "[UF209]�Ӵ���52C Ͷ��ʱ�쳣",
	[88] =  "[UF210]�Ӵ���52C �Ͽ�ʱ�쳣",
	[90] =  "[UF211]���������ʱ 52C�޷�Ӧ",
	[94] =  "[UF214]��ȴ�����쳣",
	[96] =  "[UF213]�¶ȹ���",
	[98] =  "[UF230]����λ����",
	[100] = "[UF217]�������ѹ",
	[102] = "[UF253]UPS���ƻ�·����(�������/��·ѹ��)",
	[104] = "[UF256]�����ѹ�쳣(����Χ)",
	[106] = "[UF257]52C�쳣(��������·,52C�Ͽ�ʧ��)",
	[108] = "[UF258]�����쳣",
	[110] = "[UF259]��һ̨UPS�쳣",
	[114] = "[UF301]UPS���ƻ�·����(AD�쳣ֵ)",
	[116] = "[UF302]UPS���ƻ�·����(FPGA�쳣)",
	[118] = "[UF303]UPS���ƻ�·����(WDT����)",
	[120] = "[UF323]UPS���ƻ�·����(�ع���)",
	[122] = "[UF305]UPS���ƻ�·����(FPGAʱ���쳣)",
	[124] = "[UF306]UPS���ƻ�·����(���Ƶ�Դ��ѹ��������)",
	[126] = "[UF309]�������ѹ�쳣(������Χ)",
	[128] = "[UF310]���Ƶ�Դ�쳣(�����쳣)",
	[130] = "[UF320]UPS���ƻ�·����(�����л�����߶Ͽ�)",
	[132] = "[UF331]UPS���ƻ�·����(U�����������쳣)",
	[134] = "[UF332]UPS���ƻ�·����(V�����������쳣)",
	[136] = "[UF333]UPS���ƻ�·����(W�����������쳣)",
	[138] = "[UF334]UPS���ƻ�·����(ն�������������쳣)",
	[140] = "[UF352]���Ƶ�Դ�쳣(����)",
	[142] = "[UF363]UPS���ƻ�·����(�ⲿ��ѹ����ָ���쳣)",
	[144] = "[UF372]UPS���ƻ�·����(���������·��ѹ��ͬ��)",
	[146] = "[UF374]UPS���ƻ�·����(��������ӿ��߶Ͽ�)",
	[148] = "[UF375]UPS���ƻ�·����(�����޷�ͬ��)",
	[150] = "[UF376]UPS���ƻ�·����(�����źŷ����쳣)",
	[152] = "[UF377]UPS���ƻ�·����(�������չ����ź�)",
	[154] = "[UF378]UPS���ƻ�·����(ͬ���ź�����Ӧ)",
	[156] = "[UF379]UPS���ƻ�·����(CPLDʱ���ٶ��쳣)",
	[158] = "[UF371]UPS���ƻ�·����(�����)",
	[160] = "[UF401]�Ӵ���52S�պ�ʱ����",
	[162] = "[UF402]�Ӵ���52S�Ͽ�ʱ����",
	[164] = "[UF420]��·��52L��������",
	[168] = "[UF451]�Ӵ���52S������",
	[170] = "[UF452]CB3�쳣",
	[180] = "[UA801]���������ѹ������Χ",
	[182] = "[UA802]��������Ƶ�ʳ�����Χ",
	[184] = "[UA803]���������������",
	[186] = "[UA804]��ֹ����������",
	[188] = "[UA805]���������(105%)",
	[190] = "[UA806]���������(110%)",
	[192] = "[UA807]���������(125%)",
	[194] = "[UA808]���������(150%)",
	[198] = "[UA810]���������(˲ʱ������)",
	[200] = "[UA870]��ƽ�����",
	[202] = "[UA812]��·�����ѹ������Χ",
	[204] = "[UA813]��·�����������",
	[206] = "[UA814]��·����Ƶ�ʳ�����Χ",
	[208] = "[UA815]��ֹ�л�(��·�쳣)",
	[212] = "[UA817]����ֹͣ",
	[214] = "[UA821]��ֹ�л�(������������·��ͬ��)",
	[216] = "[UA822]��ֹ�л�(�����������)",
	[218] = "[UA824]��·��72 B(CB2)��բ",
	[220] = "[UA827]��ֹ���� 52C",
	[222] = "[UA831]������·���رպ�",
	[226] = "[UA833]��·��52L ��բ",
	[228] = "[UA834]��غľ�/�������ֹͣ",
	[230] = "[UA835]��ֹ�л�(��·��Դ�쳣)",
	[232] = "[UA860]Զ�̿����쳣",
	[234] = "[UA861]�͵ؿ����쳣",
	[236] = "[UA890]�ⲿ��������",
	[240] = "[UA828]�����쳣",
}

SPListLen = #splist
dcnt,acnt,scnt,ecnt=0,0,0,0
local function DevInit()
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
		--spitem.ctrl_func
		--spitem.ctrl_reg
		
		ret=wk_RegistSP(spitem.spid,spitem.index,spitem.sptype)
		--wk_Debug(2,string.format("spid=%d,index=%d,sptype=%s,showname=%s",spitem.spid,spitem.index,spitem.sptype,spitem.showname))
		if ret==0 then --����ӵĵ㣬���ó�ʼ����ֵ
			if Language==0 then --����
				wk_ConfigSP(spid,"showname",spitem.showname)
				wk_ConfigSP(spid,"descr",spitem.descr or "")
				if sptype == "DIO" then
					wk_ConfigSP(spid,"d0desc",spitem.d0desc)
					wk_ConfigSP(spid,"d1desc",spitem.d1desc)
					if spitem.control==1 then
					wk_ConfigSP(spid,"ctrlui","0,"..spitem.d0desc.."\r\n1,"..spitem.d1desc)
					end
				elseif sptype == "ENUM" then
					wk_ConfigSP(spid,"enumstr",spitem.enumstr)
				end
      else
				wk_ConfigSP(spid,"showname",spitem.ename or "")
				wk_ConfigSP(spid,"descr",spitem.descr or "")
				if sptype == "DIO" then
					wk_ConfigSP(spid,"d0desc",spitem.end0desc or "0")
					wk_ConfigSP(spid,"d1desc",spitem.end1desc or "1")
					if spitem.control==1 then
					wk_ConfigSP(spid,"ctrlui","0,"..(spitem.end0desc or "0").."\r\n1,"..(spitem.end1desc or "1"))
					end
				elseif sptype == "ENUM" then
					wk_ConfigSP(spid,"enumstr",spitem.en2umstr or "")
				end
      end
			
			--ͨ������
			wk_ConfigSP(spid,"disable",tostring(spitem.disable or 0))
			wk_ConfigSP(spid,"save",tostring(spitem.save or 0))
			wk_ConfigSP(spid,"getonce",tostring(spitem.once or 0))
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
				--wk_ConfigSP(spid,"ratio",tostring(spitem.ratio or 1)) --ratio�Ĵ������lua��
				wk_ConfigSP(spid,"sendinterval",tostring(spitem.sendinterval or 0))
				wk_ConfigSP(spid,"minval",tostring(spitem.minval or 0))	--�ɿص�sp����������
				wk_ConfigSP(spid,"maxval",tostring(spitem.maxval or 0))
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

local function MakeMbTcpCmd(trans_id,...)
	local cmd_content=string.char(...)
	local cmd_length=#cmd_content
	return string.char(trans_id>>8,trans_id&0xFF,0,0,cmd_length>>8,cmd_length&0xFF)..cmd_content
end


RunErr=0
RetCmdErr=0
RetAddrErr=0
RetLenErr=0
ProtocolErr=0
TransactionIdErr=0
CtrlSucceed=0
CtrlFailed=0
local function AnalyMbTcpRet(trans_id,addr,cmdno,retbuf)
	local trans_id=string.char(trans_id>>8,trans_id&0xFF)
	if retbuf:sub(1,2)==trans_id then
		if retbuf:byte(3)==0 and retbuf:byte(4)==0 then
			local content_len=(retbuf:byte(5)<<8)+retbuf:byte(6)
			if #retbuf-6>=content_len then
				if addr==retbuf:byte(7) then
					if cmdno==retbuf:byte(8) then
						return 1
					else
						RetCmdErr=RetCmdErr+1
						wk_Debug(2,"cmdno err")
					end
				else
					RetAddrErr=RetAddrErr+1
					wk_Debug(2,"addr err")
				end
			else
				RetLenErr=RetLenErr+1
				wk_Debug(2,"length err")
			end
		else
			ProtocolErr=ProtocolErr
			wk_Debug(2,"protocol err")
		end
	else
		TransactionIdErr=TransactionIdErr
		wk_Debug(2,"transaction id err")
	end
	return 0
end

--ת���������ַ���Ϊ16���ƴ�ӡ��ʽ
local function Hex2Str(content, length)
	local StringHex=""
	for i=1,length or #content do
		RetByte=string.byte(content,i)
		ByteHex=string.format("%02X ",RetByte)
		StringHex=StringHex..ByteHex
	end
	--StringHex = string.upper(StringHex)
	return StringHex
end

unpack=string.unpack
string.unpack=function(str,pattern,pos)
	return unpack(pattern,str,pos or 1)
end

local function wk_ProcSP(spid,val)
	local reindex = splist[spid].index
	local sptype = splist[spid].sptype
	
	if sptype == "DIO" then
		wk_ProcDIO(spid, val)
	elseif sptype == "AIO" then
		wk_ProcAIO(spid, val)
	elseif sptype == "STR" then
		wk_ProcStr(spid, val)
	else
		wk_ProcEnum(spid, val)
	end
end

connect=0
dpvalue=0
UnitAddr=1
RetErr=0
TimeOut=0
local wk_TCPWrite;
local wk_TCPRead;

AMComm = {}

--0
--00 00 00 00 00 06 01 04 00 56 00 34 
table.insert(AMComm,function(trans_id,n)
	local mbcmd=MakeMbTcpCmd(trans_id,UnitAddr,0x04,0x00,0x56,0x00,0x34)
	--ModbusTcp.Flush()	--Flushͨ�����Ǳ���ģ�tcp�����ڴ��ڵĸ������⣬ͨ��������յ�ͨ��֮�������
	wk_TCPWrite(mbcmd)
	wk_Debug(3,"SEND"..n..":"..Hex2Str(mbcmd))
	local ret,mbret=wk_TCPRead(TimeoutMillSec)
	if ret > 0 then
		wk_Debug(3,"RECV"..n..":"..Hex2Str(mbret))
		if AnalyMbTcpRet(trans_id,UnitAddr,0x04,mbret)==1 then

			connect=1
			wk_ProcSP(1, 1)
			dpvalue = mbret:unpack(">H",34 )
			
			wk_ProcSP(2  , (mbret:unpack(">H",10 ) ~= 0XFFFF) and (mbret:unpack(">H",10 ))     or 0)				--0056
			wk_ProcSP(3  , (mbret:unpack(">H",12 ) ~= 0XFFFF) and (mbret:unpack(">H",12 ))     or 0)        --0057
			wk_ProcSP(4  , (mbret:unpack(">H",14 ) ~= 0XFFFF) and (mbret:unpack(">H",14 ))     or 0)        --0058
			wk_ProcSP(5  , (mbret:unpack(">H",16 ) ~= 0XFFFF) and (mbret:unpack(">H",16 ))     or 0)        --0059
			wk_ProcSP(6  , (mbret:unpack(">H",18 ) ~= 0XFFFF) and (mbret:unpack(">H",18 ))     or 0)        --005A
			wk_ProcSP(7  , (mbret:unpack(">H",20 ) ~= 0XFFFF) and (mbret:unpack(">H",20 ))     or 0)        --005B
			wk_ProcSP(8  , (mbret:unpack(">H",22 ) ~= 0XFFFF) and (mbret:unpack(">H",22 )/10)  or 0)       	--005C
			wk_ProcSP(9  , (mbret:unpack(">H",24 ) ~= 0XFFFF) and (mbret:unpack(">H",24 )/10)  or 0)       	--005D
			wk_ProcSP(10 , (mbret:unpack(">H",26 ) ~= 0XFFFF) and (mbret:unpack(">H",26 ))     or 0)        --005E
			wk_ProcSP(11 , (mbret:unpack(">H",28 ) ~= 0XFFFF) and (mbret:unpack(">H",28 ))     or 0)        --005F
			wk_ProcSP(12 , (mbret:unpack(">H",30 ) ~= 0XFFFF) and (mbret:unpack(">H",30 ))     or 0)        --0060
			wk_ProcSP(13 , (mbret:unpack(">H",32 ) ~= 0XFFFF) and (mbret:unpack(">H",32 )/10)  or 0)       	--0061
			wk_ProcSP(14 , (mbret:unpack(">H",34 ) ~= 0XFFFF) and (mbret:unpack(">H",34 )/10)  or 0)       	--0062
			wk_ProcSP(15 , (mbret:unpack(">H",36 ) ~= 0XFFFF) and (mbret:unpack(">H",36 )/10)  or 0)       	--0063
			wk_ProcSP(16 , (mbret:unpack(">H",38 ) ~= 0XFFFF) and (mbret:unpack(">H",38 )/10)  or 0)       	--0064
			wk_ProcSP(17 , (mbret:unpack(">H",40 ) ~= 0XFFFF) and (mbret:unpack(">H",40 )/10)  or 0)       	--0065
			wk_ProcSP(18 , (mbret:unpack(">H",42 ) ~= 0XFFFF) and (mbret:unpack(">H",42 )/10)  or 0)       	--0066
			wk_ProcSP(19 , (mbret:unpack(">H",44 ) ~= 0XFFFF) and (mbret:unpack(">H",44 )/10)  or 0)       	--0067
			wk_ProcSP(20 , (mbret:unpack(">H",46 ) ~= 0XFFFF) and (mbret:unpack(">H",46 )/10)  or 0)       	--0068
			wk_ProcSP(21 , (mbret:unpack(">H",48 ) ~= 0XFFFF) and (mbret:unpack(">H",48 )/10)  or 0)       	--0069
			wk_ProcSP(22 , (mbret:unpack(">H",50 ) ~= 0XFFFF) and (mbret:unpack(">H",50 )/10)  or 0)       	--006A
			wk_ProcSP(23 , (mbret:unpack(">H",52 ) ~= 0XFFFF) and (mbret:unpack(">H",52 ))     or 0)        --006B
			wk_ProcSP(24 , (mbret:unpack(">H",54 ) ~= 0XFFFF) and (mbret:unpack(">H",54 )/10)  or 0)        --006C
			wk_ProcSP(25 , (mbret:unpack(">H",56 ) ~= 0XFFFF) and (mbret:unpack(">H",56 ))     or 0)        --006D
			wk_ProcSP(26 , (mbret:unpack(">H",58 ) ~= 0XFFFF) and (mbret:unpack(">H",58 )/10)  or 0)        --006E
			wk_ProcSP(27 , (mbret:unpack(">H",60 ) ~= 0XFFFF) and (mbret:unpack(">H",60 )/10)  or 0)        --006F
			wk_ProcSP(28 , (mbret:unpack(">H",62 ) ~= 0XFFFF) and (mbret:unpack(">H",62 )/10)  or 0)        --0070
			wk_ProcSP(29 , (mbret:unpack(">H",64 ) ~= 0XFFFF) and (mbret:unpack(">H",64 ))     or 0)        --0071
			wk_ProcSP(30 , (mbret:unpack(">H",66 ) ~= 0XFFFF) and (mbret:unpack(">H",66 )/10)  or 0)        --0072
			wk_ProcSP(31 , (mbret:unpack(">H",68 ) ~= 0XFFFF) and (mbret:unpack(">H",68 )/10)  or 0)        --0073
			wk_ProcSP(32 , (mbret:unpack(">H",72 ) ~= 0XFFFF) and (mbret:unpack(">H",72 ))     or 0)     		--0075
			wk_ProcSP(33 , (mbret:unpack(">H",74 ) ~= 0XFFFF) and (mbret:unpack(">H",74 )/10)  or 0)        --0076
			wk_ProcSP(34 , (mbret:unpack(">H",76 ) ~= 0XFFFF) and (mbret:unpack(">H",76 )/10)  or 0)        --0077
			wk_ProcSP(35 , (mbret:unpack(">H",78 ) ~= 0XFFFF) and (mbret:unpack(">H",78 )/10)  or 0)        --0078
			wk_ProcSP(36 , (mbret:unpack(">H",80 ) ~= 0XFFFF) and (mbret:unpack(">H",80 ))     or 0)      	--0079
			wk_ProcSP(37 , (mbret:unpack(">H",70 ) ~= 0XFFFF) and (mbret:unpack(">H",70 ))     or 0)      	--0074
			wk_ProcSP(38 , (mbret:unpack(">H",82 ) ~= 0XFFFF) and (mbret:unpack(">H",82 )/10)  or 0)        --007A
			wk_ProcSP(39 , (mbret:unpack(">H",84 ) ~= 0XFFFF) and (mbret:unpack(">H",84 )/10)  or 0)        --007B
			wk_ProcSP(40 , (mbret:unpack(">H",86 ) ~= 0XFFFF) and (mbret:unpack(">H",86 )/10)  or 0)        --007C
			wk_ProcSP(41 , (mbret:unpack(">H",88 ) ~= 0XFFFF) and (mbret:unpack(">H",88 ))     or 0)     		--007D
			wk_ProcSP(42 , (mbret:unpack(">H",90 ) ~= 0XFFFF) and (mbret:unpack(">H",90 )/100) or 0)        --007E
			wk_ProcSP(43 , (mbret:unpack(">H",92 ) ~= 0XFFFF) and (mbret:unpack(">H",92 )/10)  or 0)        --007F
			wk_ProcSP(44 , (mbret:unpack(">H",94 ) ~= 0XFFFF) and (mbret:unpack(">H",94 ))     or 0)     		--0080
			wk_ProcSP(45 , (mbret:unpack(">H",96 ) ~= 0XFFFF) and (mbret:unpack(">H",96 )/10)  or 0)        --0081
			wk_ProcSP(46 , (mbret:unpack(">H",98 ) ~= 0XFFFF) and (mbret:unpack(">H",98 )/10)  or 0)        --0082	
			wk_ProcSP(47 , (mbret:unpack(">H",100) ~= 0XFFFF) and (mbret:unpack(">H",100)/10)  or 0)        --0083
			wk_ProcSP(48 , (mbret:unpack(">H",102) ~= 0XFFFF) and (mbret:unpack(">H",102)/10)  or 0)        --0084
			wk_ProcSP(49 , (mbret:unpack(">H",104) ~= 0XFFFF) and (mbret:unpack(">H",104)/10)  or 0)        --0085
			wk_ProcSP(50 , (mbret:unpack(">H",106) ~= 0XFFFF) and (mbret:unpack(">H",106)/10)  or 0)        --0086
			wk_ProcSP(51 , (mbret:unpack(">H",108) ~= 0XFFFF) and (mbret:unpack(">H",108)/10)  or 0)        --0087
			wk_ProcSP(52 , (mbret:unpack(">H",110) ~= 0XFFFF) and (mbret:unpack(">H",110)/10)  or 0)        --0088
			wk_ProcSP(53 , (mbret:unpack(">H",112) ~= 0XFFFF) and (mbret:unpack(">H",112)/10)  or 0)        --0089
														
		else
			connect=0
			RetErr=RetErr+1
			--log���������
			--Log("SEND"..n..":"..Hex2Str(mbcmd))
			--Log("RECV"..n..":"..Hex2Str(mbret))
		end
	else
		connect=0
		TimeOut=TimeOut+1
	end
end)

--1
--00 00 00 00 00 06 01 04 00 8A 00 2D 
table.insert(AMComm,function(trans_id,n)
	local mbcmd=MakeMbTcpCmd(trans_id,UnitAddr,0x04,0x00,0x8A,0x00,0x2D)
	wk_TCPWrite(mbcmd)
	wk_Debug(3,"SEND"..n..":"..Hex2Str(mbcmd))
	local ret,mbret=wk_TCPRead(TimeoutMillSec) --devcfg.TimeoutMillSec
	if ret > 0 then
		wk_Debug(3,"RECV"..n..":"..Hex2Str(mbret))
		if AnalyMbTcpRet(trans_id,UnitAddr,0x04,mbret)==1 then

			wk_ProcSP(54  , mbret:unpack(">H",48))          					 --009D

			local str
			wk_ProcSP(55  , alarmFlag[mbret:unpack(">H",50)])        --009E
			--wk_ProcSP(56  , alarmFlag[mbret:unpack(">H",52)]==" " or "")         --009F
			wk_ProcSP(56  , alarmFlag[mbret:unpack(">H",52)])         --009F
			--wk_ProcSP(56  , alarmFlag[4])         --009F
			wk_ProcSP(57  , alarmFlag[mbret:unpack(">H",54)])         --00A0
			wk_ProcSP(58  , alarmFlag[mbret:unpack(">H",56)])         --00A1
			wk_ProcSP(59  , alarmFlag[mbret:unpack(">H",58)])         --00A2
			wk_ProcSP(60  , alarmFlag[mbret:unpack(">H",60)])         --00A3
			wk_ProcSP(61  , alarmFlag[mbret:unpack(">H",62)])         --00A4
			wk_ProcSP(62  , alarmFlag[mbret:unpack(">H",64)])         --00A5
			wk_ProcSP(63  , alarmFlag[mbret:unpack(">H",66)])         --00A6
			wk_ProcSP(64  , alarmFlag[mbret:unpack(">H",68)])         --00A7
		else
			connect=0
			RetErr=RetErr+1
		end
	else
		connect=0
		TimeOut=TimeOut+1
	end
end)

local function ProcCtrlCmd(trans_id, n, spid, ctrl_value)
	--����spid������ƹ�����Ϳ���ֵ
	--[[local ctrl_func=0x06
	local ctrl_reg=0x0000
	local ctrl_data=tonumber(ctrl_value)
	if spid == 2 then
		ctrl_func=..
		ctrl_reg=..
		ctrl_data=..
	end
	--]]
	local mbcmd=MakeMbTcpCmd(trans_id,UnitAddr,0x06,0x00,0x00,0x00,0x32)
	wk_TCPWrite(mbcmd)
	wk_Debug(3,"SEND"..n..":"..Hex2Str(mbcmd))
	local ret,mbret=wk_TCPRead(TimeoutMillSec)
	if ret > 0 then
		wk_Debug(3,"RECV"..n..":"..Hex2Str(mbret))
		if AnalyMbTcpRet(trans_id,UnitAddr,mbcmd:byte(8),mbret)==1 then
			
			print("ctrl test")
			--[[
			if string.unpack(">H",mbret,9) == ctrl_data then
				--���Ƴɹ�
			else
				--����ʧ��
			end
			--]]
		else
			connect=0
			RetErr=RetErr+1
		end
	else
		connect=0
		TimeOut=TimeOut+1
	end
end

local function iter(t)
	local n = 1
	return function()
		if not wk_Run() then
			return
		end
		local f = t[n]
		local spid,ctrl_val=wk_PopCtrlCmd()
		if spid then
			return 0,ProcCtrlCmd,spid,ctrl_val
		elseif f then
			local p = n
			n = n + 1
			return p,f
		end
	end
end

function LuaStatistics()
	local statis=string.format([[
����id����%u��Э���ʶ����%u�����س��ȴ���%u��modbus��ַ����%u������Ŵ���%u
ͨ�Ž��ճ�ʱ��%u�����ش��������%u�����д��������%u�����Ƴɹ�������%u������ʧ�ܴ�����%u
��ѯ������%u���ϴβ�ѯʱ�䣺%s��ͨ��״̬��%d, ����ֵ��%f]],
	TransactionIdErr,ProtocolErr,RetLenErr,RetAddrErr,RetCmdErr,
	TimeOut,RetErr,RunErr,CtrlSucceed,CtrlFailed,PollTimes,
	os.date("%Y-%m-%d %H:%M:%S",LastTime),connect,dpvalue)
	return statis
end

PollTimes=0
Retry=0
GetAll=0
connect=0
local function AMPoll(trans_id)
while(wk_Run())
do
	for n,f,spid,val in iter(AMComm) do
		for i=0,RetryNum do
			f(trans_id,n,spid,val)
			if connect==1 then
				break
			end
		end
		if not(DebugFlag) then
			trans_id=trans_id+1
			trans_id=trans_id&0xFFFF
		end
		wk_Sleep(PollInterval)
	end
	PollTimes=PollTimes+1
	if connect==1 then
		Retry=0
		if GetAll==0 then
			GetAll=1
			--ProcDIO(1,1) --wk_ConnState(1)
		end
		--���������ϱ��߳�
		wk_SendCache()
	else
		if GetAll==1 then
			Retry=Retry+1
			if Retry>RetryNum then	
				--ProcDIO(1,0) --wk_ConnState(0)
				GetAll=0
				Retry=0
			end
		end
	end
	wk_Sleep(100)
end
end

auto_reconn=0
local function TCPException(ret)
	if ret<0 then
		error("GNCTCPERROR",0)
	end
	auto_reconn=0
end

function wk_TCPWrite(cmd)
	local ret=ModbusTCP.Write(cmd)
	TCPException(ret)
end

function wk_TCPRead(timeout_ms)
	local ret,data=ModbusTCP.Read(timeout_ms)
	TCPException(ret)
	return ret,data
end

ScriptRun=coroutine.create(function()
local run_count=50
while(wk_Run())
do
	if run_count >= 50 then
		run_count=0
		--transaction id
		local trans_id=DebugFlag and 0 or math.random(65535)
		local status,err=pcall(AMPoll,trans_id)
		if ModbusTCP.isConnected()==0 then -- err=="GNCTCPERROR"
			auto_reconn=auto_reconn+1
			if auto_reconn>3 then
				coroutine.yield()
			end
			run_count = 48   			--TCP���ӶϿ���ָ�����������
		elseif err then
			RunErr=RunErr+1				--������Lua������Ĵ�����Ϣ
			wk_Debug(1,err)
		end
	else
		run_count=run_count+1
		wk_Sleep(100)
	end
end
end)

DevInit()
time_count=150
while(wk_Run())
do
	if time_count >= 150 then --���15������
		time_count = 0
		if ModbusTCP.Connect()==1 then
			wk_ConnState(1)
			coroutine.resume(ScriptRun)
			wk_ConnState(0)
		end
	else
		time_count=time_count+1
		wk_Sleep(100)
	end
end