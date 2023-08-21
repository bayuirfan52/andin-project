# andin_project

Interactive learning untuk anak berkebutuhan khusus.

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
- Flow aplikasi dan wireframe ui dapat dilihat di (https://drive.google.com/file/d/1p60wrGuoBrOqHhQlR6UVq_gjeWzZdVa2/view?usp=sharing)

---

### Sebelum mulai, mari Set-Up tools / install dibawah:

- **get_cli** : terminal : `pub global activate get_cli` atau `dart pub global activate get_cli`
- **plug-in : getXSnippet** vscode / intellij
- **plug-in : FlutterJsonBeanFactory**  intellij
- **dart line** : set line to 200, biar reformatting code nya tetap rapi. ![image](https://user-images.githubusercontent.com/36602270/142856350-d62bfe1b-7af2-43de-8455-ace88a92078e.png)

---

### PENTING!!
- untuk membuat fitur baru, terminal : `get create page:test_page`
- untuk membuat class beans (entity / model) gunakan generator **FlutterJsonBeanFactory** (intellij)
- run `flutter packages pub run build_runner build` first!

---

### How to Run With Flavor
```
- Update your editor run script with argument --flavor={FlavorName}
- or run manually on terminal `flutter run --flavor={FlavorName}`
- Flavor Name list:
    - Development `flutter run --flavor=Development`
    - Staging `flutter run --flavor=Staging`
    - Production `flutter run --flavor=Production`
```