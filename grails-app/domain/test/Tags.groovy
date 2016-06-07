package test

class Tags {
    String name
    Date create_time
    Integer user_id
    static constraints = {
        name nullable: false, size: 1..100
    }
}
