#PASS_ICON = File.expand_path('../../public/images/weather-clear.png',   __FILE__)
#FAIL_ICON = File.expand_path('../../public/images/weather-showers.png', __FILE__)

PASS_ICON = "~/Pictures/success.jpg"
FAIL_ICON = "~/Pictures/failure.jpg"

def notify(icon, heading, body)
    cmd = "growlnotify --image #{icon} -m '#{body}' '#{heading}'"
    system(cmd)
end

def run_tests(test, force=false)
  if force || File.exist?(test)
    puts "-" * 80
    puts "Running #{test}..."
    cmd = IO.popen("bundle exec rspec --color --tty --drb --format=doc #{test} 2>&1")
    result = ''
    until cmd.eof?
      line = cmd.gets
      result << line
      print line
    end
    if result =~ /(\d+) failure/ and (failures = $1.to_i) > 0
      notify(FAIL_ICON, 'Test Failure', "#{failures} test#{failures == 1 ? ' has' : 's have'} failed!")
    else
      notify(PASS_ICON, 'Test Success', 'All tests passing.')
    end
    $stdout.write(result)
  else
    puts "#{test} does not exist."
  end
end

watch('spec/(.*/*)_spec\.rb') { |m| run_tests("spec/#{m[1]}_spec.rb") }
watch('app/(.*)\.rb'        ) { |m| run_tests("spec/#{m[1]}_spec.rb") }

@interrupt_received = false
Signal.trap 'INT' do
  if @interrupt_received
    exit 0
  else
    @interrupt_received = true
    puts "\nInterrupt a second time to quit"
    Kernel.sleep 1
    @interrupt_received = false
    run_tests('spec/**/*_spec.rb', :force)
  end
end
