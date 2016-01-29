module ApplicationHelper

	def check_editor_access(user, itemid, commentaryid)
		answer = false
		user.access_points.each do |ap| 
			if ap.editor? && ap.itemid == "all" && ap.commentaryid == commentaryid
				answer = true
				break
			elsif ap.editor? && ap.itemid == itemid && ap.commentaryid = commentaryid
				answer = true
				break
			end  
		end
		return answer
	end
end
