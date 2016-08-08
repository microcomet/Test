package smartcommunity

class Score {

    String name
    Integer type
    Integer score

    static constraints = {
        name nullable: false, size: 1..100
        type nullable: false
        score nullable: false
    }
}
