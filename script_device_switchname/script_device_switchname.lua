-- Domoticz LUA Script - script_device_<switchname>.lua
-- ----------------------------------------------------
-- This script will toggle a series of (virtual) switches in Domoticz based
-- on a trigger switch. The number of switches that are included and the action
-- ('On' or 'Off') will be set through a series of variables which makes this
-- script easily adaptable and reusable.
--
-- Usage:
-- Within the customisation section below, do
-- 1. Update the trigger variable with the Domoticz name of the switch that will trigger the actions.
-- 2. set variable i to the total number of switches that will change state based on the triggered action.
-- 3. For each of the switches that will change, add the name to the switch[x] variable and the command (on or off) to the command[x] variable.

-- WimFey97
-- V1.0 - 02122015 - Initial Version 

switch = {}		-- array definition. Do not modify
command = {}	-- array definition. Do not modify
rcommand = {}	-- array definition. Do not modify

-- Start of Customisation Section
---------------------------------------------------------------------------------------------------------------------------- 
trigger='Test1'	-- This defines the trigger switch. Use the (cases-sensitive) name of the switch in Domoticz that you want to use.
i = 2			-- This defines the number of switches that will be impacted by the trigger switch.

-- Customise the next section. For each switch that will need to act upon the trigger, add the name and the required action
-- ("On" or "Off") when the trigger switch is turned "On". The reverse action will be taken when the trigger is turned off.
-- Note that the number of declarations must be identical to the variable 'i' which is defined above.

switch[1] = 'Test2'  
command[1] = 'On'   -- This defines to turn switch Test2 "On" when switch Test1 is turned "On".
switch [2] = 'Test3'
command[2] = 'Off'  -- This defines to turn switch Test3 "Off" when switch Test1 is turned "On".

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