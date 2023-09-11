# AVIC

Autism visual communication for early student.
![image](https://github.com/bayuirfan52/andin-project/blob/main/assets/images/img_splash.png)

## Getting Started

Project ini dibangun menggunakan:
- flutter versi `v3.7.3`
- `GetX` ekosistem.
- `VelocityX` A minimalist Flutter framework for rapidly building custom designs.

---

### Documentation
- [Flutter](https://docs.flutter.dev/)
- [GetX](https://chornthorn.github.io/getx-docs/index)
- [VelocityX](https://velocityx.dev/docs/install)

### Development Guidelines :
- Design Pattern **MVC**
- Karna menggunakan `linter`, sebelum commit, pastikan check `Dart Analysis` count = 0, keep clean code sesuai anjuran flutter.
- Flow aplikasi dan wireframe ui dapat dilihat di [Andin Project - Apps Development Guidelines](https://drive.google.com/file/d/1p60wrGuoBrOqHhQlR6UVq_gjeWzZdVa2/view?usp=sharing)

---

### Sebelum mulai, mari Set-Up tools / install dibawah:

- **get_cli** : terminal : `pub global activate get_cli` atau `dart pub global activate get_cli`
- **plug-in : getXSnippet** vscode / intellij
- **dart line** : set line to 200, biar reformatting code nya tetap rapi. ![image](https://user-images.githubusercontent.com/36602270/142856350-d62bfe1b-7af2-43de-8455-ace88a92078e.png)

---

### PENTING!!
- untuk membuat fitur baru, terminal : `get create page:test_page`
- run `flutter packages pub run build_runner build` first!

---

### How to Run With Flavor
- Update your editor run script with argument `--flavor={FlavorName}`
- or run manually on terminal `flutter run --flavor={FlavorName}`
- Flavor Name list:
    - Staging ```flutter run --flavor=Staging```
    - Production ```flutter run --flavor=Production```
