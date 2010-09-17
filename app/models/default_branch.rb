class DefaultBranch
  def self.get
    company = Company.find_by_name('Santhathi')
    branch = company.branches.find_by_name('Main')    
    return branch
  end

  def self.company
    company = Company.find_by_name('Santhathi')
    return company
  end
end
