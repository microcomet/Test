package smartcommunity

class HomeController {

    def index() {
        def result = [:]

        def admin = new User()

        result['totalUserNum'] = User.countByRoleAndNameIsNotNull(Role.findByRole(2))
        result['totalWishNum'] = Desire.countByDescriptionIsNotNull()
        result['totalTopicNum'] = Topic.countByContentIsNotNull()
        result['totalVoteNum'] = Poll.countByIdIsNotNull()
        result['totalOrderNum'] = ServiceReservation.countByIdIsNotNull()

        respond admin , model: [dataAnalysis: result]
    }
}
