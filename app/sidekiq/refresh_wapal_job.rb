class RefreshWapalJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    Wapal::CollectionInfoUpdater.call
  end
end
