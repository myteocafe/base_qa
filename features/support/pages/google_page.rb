class GooglePage
  include PageObject

  page_url FigNewton.url_google



  element(:txt_username, :name => "q")
  element(:btn_search, :name => "btnK")
  element(:first_result, :xpath => "//h3[@class='LC20lb'][1]")



  def loaded?
    begin
      Watir::Wait.until {
        txt_username_element.when_present(30)
        true
      }
    rescue => error
      puts error.to_s
      false
    end
  end


  def set_search(txt)
    txt_username_element.send_keys txt
    btn_search_element.when_present(30).click
  end

  def get_first_google_result
    first_result_element.when_present(30).text
  end


  def click_first_google_result
    first_result_element.when_present(30).click
  end

end