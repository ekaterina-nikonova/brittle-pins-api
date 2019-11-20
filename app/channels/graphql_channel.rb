class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    result = execute_query(data)
    payload = {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?
    }
    @subscription_ids << context[:subscription_id] if result.context[:subscription_id]

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |id|
      BrittlePinsApiSchema.subscriptions.delete_subscription(id)
    end
  end

  private

  def execute_query(data)
    BrittlePinsApiSchema.execute(
      query: data['query'],
      context: context,
      variables: ensure_hash(data['variables']),
      operation_name: data['operationName']
    )
  end

  def context
    {
      channel_user: channel_user,
      channel: self
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
