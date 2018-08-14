class CodicesController < ApplicationController
  def list
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
        h[:surface_title].to_s
      }
    }


  end
end
