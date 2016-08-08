package smartcommunity

class UserSMSCode {
    String mobile
    String smsCode
    Date create_time
    Date update_time

    static constraints = {
        mobile nullable: false
        smsCode nullable: false
    }
}
