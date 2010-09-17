module AccountsHelper

  def account_group_options_array
    user_default_branch.account_groups.all.map{|m| [m.name, m.id]}
  end

  def grouped_account_group_options_array
    a = []
    user_default_branch.account_group_types.all.each do |agt|
      b = agt.account_groups.all.map{|m| [m.name, m.id]}
      a << [agt.name, b]
    end
    return a
  end

end
