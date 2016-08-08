package smartcommunity

//民意征询选项类
class PollOption {
    Poll poll
    String option_text
    String option_desc
    Date create_time
    Date update_time

    static constraints = {
        poll nullable: false
        option_text nullable: false, size: 1..500
        option_desc size: 0..1000
    }
}
