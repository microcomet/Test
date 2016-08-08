package smartcommunity

class DesireFeedback {

    Desire desire
    User feeder
    String feedContent
    Integer status  //[1: 有效  2: 无效]
    Date feedTime
    Date updateTime

    static constraints = {
    }
}
