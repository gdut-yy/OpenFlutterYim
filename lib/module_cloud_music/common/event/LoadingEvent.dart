class LoadingEvent{
  bool show;

  LoadingEvent.show() {
    show = true;
  }

  LoadingEvent.hide() {
    show = false;
  }
}