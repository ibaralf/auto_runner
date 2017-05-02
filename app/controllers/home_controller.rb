class HomeController < ApplicationController
  
  def index
    @tests = Array.new(3)
  end
  
  def save_data
    fname = "testruns.rb"
    puts "PARAMS: #{params}"
    if ! params.has_key?(:tests) && ! params.has_key?(:admintests)
       flash[:error] = "Please select a test to run."
      redirect_to action: 'index'
    else
      txt_torender = create_textfile(params)
      render :text => txt_torender
    end
  end
  
  def test_me
    render "NOTHIGN HERE"
  end
  
  def show_results
    @resfiles = Dir.glob
  end
  
  private
  
  def create_textfile(passed_data)
    to_render = "<h2> Your test has been scheduled. 
    <br/>To view (Mac only), click on <a href='vnc://10.0.200.170'>Mac Screen Sharing</a> <br/> Starts in about 1 minute.
    <br/><br/>To view results, click on <a href='https://test.aspera.us/testrail/index.php?/runs/overview/5' target='_blank'>Test Rails</a> <br/>"
    uhome = ENV["HOME"]
    #filename = "C:\\Users\\Administrator\\Documents\\NewNav_FilesWebdriver\\AsperaAutomation\\Test_Suite_Web\\files_ui\\selected_tests.txt"
    can_schedule = true
    if params.has_key?(:admintests)
      filename = uhome + "\\Documents\\NewNav_FilesWebdriver\\AsperaAutomation\\Test_Suite_Web\\files_ui\\admin_selected_tests.txt"
      if ! File.exist?(filename)
        File.open(filename, "w") do |file|
          file.write("host= #{passed_data[:host]}\n")
          file.write("backend= #{passed_data[:backend]}\n")
          file.write("email= #{passed_data[:email]}\n")
          file.write("password= #{passed_data[:password]}\n")
          file.write("node_name= #{passed_data[:node_name]}\n")
          file.write("node_secret= #{passed_data[:node_secret]}\n")
          file.write("node_folder= Autows\n")
          file.write("node_name_admin_share= #{passed_data[:node_name_admin_share]}\n")
          file.write("node_secret_admin_share= #{passed_data[:node_secret_admin_share]}\n")
          
          str_tests = ""
          passed_data[:admintests].each do |untest|
            str_tests = str_tests + untest + " "
          end
          file.write("tests= #{str_tests.chomp(' ')}")
        end
      else
        to_render = "<br/><h2>NOTE: Sorry, a previous test is currently scheduled or running.</h2>"
        can_schedule = false
      end
    end

    if params.has_key?(:tests) && can_schedule
      filename = uhome + "\\Documents\\NewNav_FilesWebdriver\\AsperaAutomation\\Test_Suite_Web\\files_ui\\selected_tests.txt" 
      if ! File.exist?(filename)
        File.open(filename, "w") do |file|
          file.write("host= #{passed_data[:host]}\n")
          file.write("backend= #{passed_data[:backend]}\n")
          file.write("email= #{passed_data[:email]}\n")
          file.write("password= #{passed_data[:password]}\n")
          file.write("node_name= #{passed_data[:node_name]}\n")
          file.write("node_secret= #{passed_data[:node_secret]}\n")
          file.write("node_folder= Autows\n")
          file.write("node_name_admin_share= #{passed_data[:node_name_admin_share]}\n")
          file.write("node_secret_admin_share= #{passed_data[:node_secret_admin_share]}\n")
          
          str_tests = ""
          passed_data[:tests].each do |untest|
            str_tests = str_tests + untest + " "
          end
          file.write("tests= #{str_tests.chomp(' ')}")
        end
      else
        to_render = "<br/><h2>NOTE: Sorry, a previous test is currently scheduled or running.</h2>"
      end
    end
    
    return to_render
  end
  
end
