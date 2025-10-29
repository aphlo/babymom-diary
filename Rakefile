require "rake"

def run_command(command)
  puts "→ #{command}"
  system(command) || abort("Command failed: #{command}")
end

def with_args(base_command)
  extra_args = ENV["ARGS"].to_s.strip
  return base_command if extra_args.empty?

  "#{base_command} #{extra_args}"
end

TASKS = {
  run_prod: {
    command: "fvm flutter run --flavor prod -t lib/main_prod.dart",
    description: "Run app with prod flavor (set ARGS for extra flutter flags)",
  },
  run_local: {
    command: "fvm flutter run --flavor local -t lib/main_local.dart",
    description: "Run app with local flavor (set ARGS for extra flutter flags)",
  },
  format: {
    command: "fvm dart format lib test",
    description: "format dart files",
  },
  test: {
    command: "fvm flutter test",
    description: "Run Flutter tests (set ARGS to pass extra options)",
  },
  lint: {
    command: "fvm flutter analyze",
    description: "Run Flutter analyzer (set ARGS to pass extra options)",
  },
}.freeze

TASKS.each do |name, config|
  desc config.fetch(:description)
  task name do
    run_command(with_args(config.fetch(:command)))
  end
end

desc "Default task runs the production flavor"
task default: :run_prod
