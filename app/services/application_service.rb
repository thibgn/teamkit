class ApplicationService
  Result = Struct.new(:success?, :payload, :error, keyword_init: true)

  def self.call(...) = new(...).call

  private

  def success(payload: nil) = Result.new(success?: true, payload: payload)

  def failure(error:) = Result.new(success?: false, error: error)
end
