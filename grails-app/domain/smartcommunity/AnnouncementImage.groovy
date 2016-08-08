package smartcommunity

//公告相关图片
class AnnouncementImage {
    Announcement announcement
    Image image
    Integer status //[1: 正常 2：删除]

    static constraints = {
        announcement nullable: false
        image nullable: false
    }
}
