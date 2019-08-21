Sidekiq::Cron::Job.create(
  name: 'Workarea::Exporting::GoogleFeed',
  klass: 'Workarea::Exporting::GoogleFeed',
  cron: '0 5 * * *',
  queue: 'low'
)
