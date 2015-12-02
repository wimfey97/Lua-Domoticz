-- Domoticz LUA Script - script_device_<switchname>.lua
-- ----------------------------------------------------
-- This script will toggle a series of (virtual) switches in Domoticz based
-- on a trigger switch. The number of switches that are included and the action
-- ('On' or 'Off') will be set through a series of variables which makes this
-- script easily adaptable and reusable.
--
-- Usage:
-- 1. 
-- WimFey97
-- V1.0 - 02122015 - Initial Version 


trigger='Test1'	-- This defines the trigger switch. Use the (cases-sensitive) name of the switch in Domoticz that you want to use.
i = 2			-- This defines the number of switches that will be impacted by the trigger switch.
switch = {}		-- array definition. Do not modify
command = {}	-- array definition. Do not modify
rcommand = {}	-- array definition. Do not modify

-- Customise the next section. For each switch that will need to act upon the trigger, add the name and the required action
-- ("On" or "Off") when the trigger switch is turned "On". The reverse action will be taken when the trigger is turned off.
-- Note that the number of declarations must be identical to the variable 'i' which is defined above.

switch[1] = 'Test2'  -- This defines to turn switch Test2 "On" when switch Test1 is turned "On".
command[1] = 'On'
switch [2] = 'Test3'
command[2] = 'Off'

-- Use loging = 0 to stop logging messages to the Domoticz Log
-- Use loging = 1 to log actions

loging = 1

-- End of customisation section

-- Start of Logic (no need to modify)
---------------------------------------------------------------------------------------------------------------------------- 
commandArray = {}
 -- Init reverse commands
 for n = 1,i do
   if command[n] == 'On' then rcommand[n] = 'Off' else rcommand[n] = 'On' end  
 end
 
 -- do this when trigger is turned on.
if (devicechanged[trigger]) == 'On' then 
	for n = 1,i do
	    print(switch[n])
		if otherdevices[switch[n]] ~= command[n] then  -- only execute action on target switch if not yet in desired state.
			commandArray[switch[n]] = command[n]
		end
	end
end
-- do this when trigger is turned off.
if (devicechanged[trigger]) == 'Off' then 
	for n = 1,i do
		if otherdevices[switch[n]] ~= rcommand[n] then  -- only execute action on target switch if not yet in desired state.
			commandArray[switch[n]] = rcommand[n]
		end
	end
end
return commandArray