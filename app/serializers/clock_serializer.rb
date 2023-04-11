class ClockSerializer
  include JSONAPI::Serializer
  attributes :id, :clock_in_time, :clock_out_time, :user_id, :created_at
end
