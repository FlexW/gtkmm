#include <gtkmm.h>

class MyWindow : public Gtk::Window
{
public:
  MyWindow();
private:
  Gtk::Button b;
  Gtk::Box vbox;
};

MyWindow::MyWindow() :
  b("hello"),
  vbox(Gtk::Orientation::VERTICAL)
{
  add(vbox);
  b.set_expand(true);
  vbox.add(b);
}

int main (int argc, char *argv[])
{
  auto app = Gtk::Application::create();

  MyWindow window;
  return app->run(window, argc, argv);
}
