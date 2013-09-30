
module WebsocketRails

  module SpecHelpers

      def self.verify_route(event, target, non_exclusive)

        raise ArgumentError, 'event must be of type SpecHelperEvent' unless event.is_a? WebsocketRails::SpecHelperEvent
        target_class, target_method = WebsocketRails::TargetValidator.validate_target target

        result = false
        no_of_routes = 0
        event.dispatcher.event_map.routes_for event do |controller_class, method|
          no_of_routes += 1
          controller = controller_class.new
          if controller.class == target_class and method == target_method
            result = true
          end
        end
        result and (non_exclusive or no_of_routes == 1)
      end

  end

end

module MiniTest::Assertions
  def assert_routed_to(event, route, message = nil)
    assert WebsocketRails::SpecHelpers.verify_route(event, route, true), "expected event #{event.name} to be routed to target #{route}"
  end
end
