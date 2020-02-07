class GoogleResultPage
  include PageObject

  element(:btn_sunat_result, :xpath => "//h3[contains(text(),'Tipo de Cambio Oficial - SUNAT')]")


  def loaded?
    begin
      Watir::Wait.until {
        btn_sunat_result_element.when_present(30)
        true
      }
    rescue => error
      puts error.to_s
      false
    end
  end


  def click_result
    btn_sunat_result_element.when_present(30).click
    sleep 5
  end

end