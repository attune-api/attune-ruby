require 'spec_helper'

describe Attune::Client do
  subject { described_class.new(options) }
  context "with defaults" do
    let(:options){ {} }
    specify { expect(subject.endpoint).to eq(Attune::Default::ENDPOINT) }
    specify { expect(subject.middleware).to eq(Attune::Default::MIDDLEWARE) }
  end
  context "with custom endpoint" do
    let(:endpoint){ 'http://example.com/' }
    let(:options){ {endpoint: endpoint} }
    specify { expect(subject.endpoint).to eq(endpoint) }
  end
end
