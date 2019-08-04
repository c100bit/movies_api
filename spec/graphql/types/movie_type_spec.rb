RSpec.describe Types::MovieType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:title).of_type('String!') }
  it { is_expected.to have_field(:localTitle).of_type('String!') }
  it { is_expected.to have_field(:year).of_type('Int!') }
  it { is_expected.to have_field(:rate).of_type('Int!') }
  it { is_expected.to have_field(:text).of_type('String!') }
  it { is_expected.to have_field(:imageUrl).of_type('String!') }
  it { is_expected.to have_field(:genres).of_type('[Genre!]') }
end 