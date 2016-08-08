package smartcommunity

//预约表类
class ServiceReservation {
    ServiceItem serviceItem
    User reserve_person
    User clerk
    Date order_date
    Date server_time
    String server_desc
    String status //[1: 等待确认 2：通过 3：不通过]
    Date create_time
    Date update_time

    static constraints = {
        serviceItem nullable: false
        reserve_person nullable: false
        server_desc size: 1..1000
    }
}
