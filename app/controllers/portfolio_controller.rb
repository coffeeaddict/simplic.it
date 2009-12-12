class PortfolioController < ApplicationController
  before_filter :check_login, :except => [ :index ]

  def index
    @portfolio = Portfolio.all :conditions => { :published => true },
      :order => "created_at DESC"
  end

  def admin
    @portfolio = Portfolio.all
  end

  def edit
    @portfolio = Portfolio.find(params[:id])

    if params[:portfolio]
      @portfolio.update_attributes(params[:portfolio])
    end
  end

  def new
    portfolio = Portfolio.create();
    redirect_to :action => :edit, :id => portfolio.id
  end

  def destroy
    Portfolio.find(params[:id]).destroy
    redirect_to :action => :admin
  end

  def add_skill
    pf = Portfolio.find(params[:id])
    skill = Skill.find(params[:skill_id])
    unless pf.skills.include? skill
      pf.skills << skill 
      render(:update) { |page|
        page.insert_html( :bottom, 'project_skills',
          render(:partial => "project_skill", :locals => { :skill => skill })
        )
      }
    else
      render :text => "Already has that skill"
    end
  end

  def drop_skill
    pf = Portfolio.find(params[:id])
    skill = Skill.find(params[:skill_id])
    pf.skills = pf.skills - [ skill ]

    render(:update) { |page|
      page.remove "project_skill_#{skill.id}"
      page.replace_html 'message', 'OK!'
    }

    return "OK"
  end

  def new_skill
    skill = Skill.create(params[:skill])
    
     render(:update) { |page|
       page.insert_html( :bottom, 'available_skills',
         render(:partial => "skill", :locals => { :skill => skill })
       )
     }
  end

end
