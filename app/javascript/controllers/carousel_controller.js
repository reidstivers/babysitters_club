import Carousel from '@stimulus-components/carousel'

export default class extends Carousel {
  connect() {
    super.connect()
    console.log('Do what you want here.')

    // The swiper instance.
    this.swiper

    // Default options for every carousels.
    this.defaultOptions
  }

  // You can set default options in this getter.
  get defaultOptions() {
    return {
      // Your default options here
    }
  }
}
