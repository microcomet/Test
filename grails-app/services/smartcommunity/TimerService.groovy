package smartcommunity

import grails.transaction.Transactional

import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit

@Transactional
class TimerService {

    ScheduledExecutorService scheduledExecutorService

    def close_flag = 1

    TimerService() {
        scheduledExecutorService = Executors.newScheduledThreadPool(2)
    }

    def autoOperation(){
        scheduledExecutorService.scheduleAtFixedRate(new Runnable() {
            @Override
            void run() {

                while(close_flag) {
                    confirmTinyWish()
                    enablePoll()
                }
            }
        }, 5, 5, TimeUnit.MINUTES)
    }

    def confirmTinyWish(){
        def desireList = Desire.findAllByStatusInList([3, 4])
        def now = new Date()
        desireList.each { wish ->
            if (wish.status == 3 && ((now.time - wish.finish_time.time) / 3600000 >= 24)) {
                wish.status = 5
                wish.submit_time = now
                wish.update_time = now
                wish.save(flush: true)
            }

            if (wish.status == 4 && ((now.time - wish.submit_time.time) / 3600000 >= 24)) {
                wish.status = 5
                wish.finish_time = now
                wish.update_time = now
                wish.save(flush: true)
            }
        }
    }

    def enablePoll() {
        def voteList = Poll.findAllByStatus(2)
        def now = new Date()
        voteList.each {vote ->
            if (now.time > vote.start_time.time && now.time < vote.end_time.time) {
                vote.status = 1
                vote.save(flush: true)
            }
        }
    }

    def disableSMSCode(){
        scheduledExecutorService.scheduleAtFixedRate(new Runnable() {
            @Override
            void run() {

//                while(close_flag){
//
//                }

            }
        }, 5000, 5000, TimeUnit.MILLISECONDS)
    }

    def close(){
        close_flag = 0
        scheduledExecutorService.shutdownNow()
    }


}
