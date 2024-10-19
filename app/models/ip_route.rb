class IpRoute
  include ActiveModel::Model

  ATTRS = %i[id comment distance immediate_gw dynamic static active inactive disabled primary].freeze

  attr_accessor(*ATTRS)

  def self.new_from_unsafe_hash(args)
    new(args.select { |key, value| ATTRS.include?(key) })
  end

  def name
    comment || id
  end
end
