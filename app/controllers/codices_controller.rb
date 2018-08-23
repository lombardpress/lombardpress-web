class CodicesController < ApplicationController
  def list
    @results = MiscQuery.new.all_codex_display_list()
  end
  def show
    if params[:resourceid]
      id = params[:resourceid]
    else
      id = "http://scta.info/resource/#{params[:shortid]}"
    end

    @results = MiscQuery.new.codex_display_list(id)

    @surface_group = @results.group_by { |result|
      result[:expression]
      }.each{|_, v|
        v.map!{|h|
          info = {
            surface_title: h[:surface_title].to_s,
            surface_short_id: h[:surface].to_s.split("resource/").last()
          }
          

      }
    }



  end
end
