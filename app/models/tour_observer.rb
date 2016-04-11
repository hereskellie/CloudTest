require 'my_logger'

class TourObserver < ActiveRecord::Observer
    
    def after_update(record)
        #use my logger instance method to retrieve the single instance
        @logger = MyLogger.instance
        @logger.logInformation("########################")
        @logger.logInformation("+++ TourObserver: The tour of #{record.firstname} #{record.lastname} has been updated. cost #{record.cost}")
        @logger.logInformation("########################")
    end
end