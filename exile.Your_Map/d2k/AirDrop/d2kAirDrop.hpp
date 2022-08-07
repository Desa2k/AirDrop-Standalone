
class d2kAirDrop
{
	idd = 9000;
	onLoad = "uiNamespace setVariable ['d2kAirDrop', (_this select 0)];";
	onUnLoad = "uiNamespace setVariable ['d2kAirDrop', displayNull];";
	movingEnable = false;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.225;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.55;
			style = 48;
			text = "d2k\AirDrop\icons\fire.jpg";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			moving = false;
			
		};
		
	};
	class Controls
	{
		class Button1
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.34322917;
			y = safeZoneY + safeZoneH * 0.61296297;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03796297;
			style = 0+2;
			text = "Vehicle";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[] call d2k_fnc_updateListBoxV;";
			
		};
		class Button2
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.46822917;
			y = safeZoneY + safeZoneH * 0.61296297;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03796297;
			style = 0+2;
			text = "Supply";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[] call d2k_fnc_updateListBoxS;";
			
		};
		class Button3
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.59322917;
			y = safeZoneY + safeZoneH * 0.61296297;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03796297;
			style = 0+2;
			text = "Food";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[] call d2k_fnc_updateListBoxF;";
			
		};
		class Button4
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.44322917;
			y = safeZoneY + safeZoneH * 0.67;
			w = safeZoneW * 0.1203125;
			h = safeZoneH * 0.06296297;
			style = 0+2;
			text = "Purchase";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "[] call d2k_fnc_StartDrop;";
			
		};
		class ListBox1
		{
			type = 5;
			idc = 1337;
			x = safeZoneX + safeZoneW * 0.34375;
			y = safeZoneY + safeZoneH * 0.35;
			w = safeZoneW * 0.3125;
			h = safeZoneH * 0.225;
			style = 16;
			colorBackground[] = {0.4,0.4,0.4,0.6353};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorText[] = {0.2431,0.6902,0.3098,1};
			font = "TahomaB";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			access = 0;
			onLoad = "[] spawn d2k_fnc_updateListBoxV;";
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class Title1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.23796297;
			w = safeZoneW * 0.3;
			h = safeZoneH * 0.075;
			style = 48;
			text = "d2k\AirDrop\icons\banner.jpg";
			colorBackground[] = {0.6,0,0,1};
			colorText[] = {1,1,1,1};
			font = "EtelkaMonospaceProBold";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 3);
			moving = false;
			
		};
		class Logo
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.225;
			w = safeZoneW * 0.05520834;
			h = safeZoneH * 0.1;
			style = 48;
			text = "d2k\AirDrop\icons\gowlogosm.paa";
			colorBackground[] = {0.0784,0.8392,0.149,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Title2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.34375;
			y = safeZoneY + safeZoneH * 0.325;
			w = safeZoneW * 0.0625;
			h = safeZoneH * 0.025;
			style = 2;
			text = "Drop";
			colorBackground[] = {0.6,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Title3
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.59375;
			y = safeZoneY + safeZoneH * 0.325;
			w = safeZoneW * 0.0625;
			h = safeZoneH * 0.025;
			style = 2;
			text = "Price";
			colorBackground[] = {0.6,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Title4
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.40625;
			y = safeZoneY + safeZoneH * 0.325;
			w = safeZoneW * 0.1875;
			h = safeZoneH * 0.025;
			style = 2;
			text = "";
			colorBackground[] = {0.6,0,0,1};
			colorText[] = {1,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};
