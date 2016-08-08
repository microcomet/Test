package smartcommunity

//心愿相关图片
class DesireImage {
    Desire desire
    Image image
    Integer status //[1：正常 2：删除]

    static constraints = {
        desire nullable: false
        image nullable: false
    }
}
