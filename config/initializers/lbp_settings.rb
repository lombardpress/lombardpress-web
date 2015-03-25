#These configs need to eventually be put in a yaml find and then pulled out 
require_relative 'lbp_project_configs'

if `hostname` == 'petrusplaoul.org'
	set_plaoul_config
elsif `hostname` == 'petrusgracilis.lombardpress.org'
	set_gracilis_config
elsif `hostname` == 'adamwodeham.org'
	set_wodeham_config
else
	#set_wodeham_config
	#set_gracilis_config
	set_plaoul_config
end



