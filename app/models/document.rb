class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :request, optional: true

  has_many :reviewables, through: :document_type
  has_many :reviews, dependent: :destroy

  before_validation :record_parsed_uri, if: :will_save_change_to_url? # url_changed?
  before_create :complete_request
  validate :valid_unique_url

  def self.search(query)
    scope = includes(:document_type, :reviews)

    if query.present?
      scope = scope.where("documents.name ILIKE :query OR documents.company_name ILIKE :query", query: "%#{query}%")
    end

    scope.all.order("company_name DESC")
  end

  # Returns a document by the hostname and path given,
  # If there is no path, maybe the site does it's url
  # exclusively via query params... so search by
  # the host + query instead.
  def self.search_for_url(url)
    uri = URI.parse(url)
    docs = where(uri_host: uri.host.to_s.sub(/^www\./, ""))
    if uri.path.present?
      docs = docs.where(uri_path: uri.path)
    else
      docs = docs.where(uri_path: uri.path, uri_query: uri.query)
    end
    return docs.last
  end

  def summarize_scores
    @summarize_scores = Review.summarize_scores(self)
  end

  def overall_score
    @overall_score ||= begin
      scores = Review.summarize_scores(self).map(&:avg_score)
      return nil if scores.empty?
      scores.sum / scores.size
    end
  end

  private

  # before_validation
  def record_parsed_uri
    return if url.blank?

    self.url = if url.to_s =~ %r{https?://}
      url
    else
      "http://#{url}"
    end

    uri = URI.parse(self.url)
    # Don't save the 'www.' part of the host, so that something like
    # "facebook.com" and "www.facebook.com" will both match,
    # but "apps.facebook.com" will not.
    self.uri_host = uri.host.sub(/^www\./, "")
    self.uri_path = uri.path
    self.uri_query = uri.query
    self.uri_fragment = uri.fragment
  rescue URI::InvalidURIError
    self.uri_host = nil
    self.uri_path = nil
    self.uri_query = nil
    self.uri_fragment = nil
  end

  def valid_unique_url
    if uri_host.blank? || url.blank?
      errors.add(:url, "appears to be invalid")
      return false
    end

    docs = Document
    unless new_record?
      # Exclude self id if this is an update on an
      # existing record.
      docs = docs.where.not(id: self.id)
    end
    docs = docs.search_for_url(self.url)

    if docs.present?
      errors.add(:url, "must be unique")
    end
  end

  def complete_request
    if self.request_id
      self.request.complete
    end
  end
end
