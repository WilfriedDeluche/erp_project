module CompaniesHelper
  
  def contact_name(company)
    chaine = ""
    chaine += "#{company.contact_first_name.capitalize} " unless company.contact_first_name.nil? # otherwise error in case attr is nil
    chaine += company.contact_last_name.upcase unless company.contact_last_name.nil?
    chaine
  end
end
