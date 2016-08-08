package smartcommunity

//投票记录类
class PollRecord {
    Poll poll
    User voter
    Date vote_time
    PollOption pollOption
    Integer score
    Integer status
    Date create_time
    Date update_time

    static constraints = {
        poll nullable: false
        voter nullable: false
        vote_time nullable: false
        pollOption nullable: false
        score nullable: false
        status nullable: false
    }
}
