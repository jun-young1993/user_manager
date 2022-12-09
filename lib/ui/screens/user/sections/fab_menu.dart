part of 'package:user_manager/ui/screens/user/user.dart';

class _FabMenu extends StatefulWidget {
  const _FabMenu();

  @override
  State<_FabMenu> createState() => _FabMenuState();
}


class _FabMenuState extends State<_FabMenu> with SingleTickerProviderStateMixin {
    late AnimationController _fabController;
    late Animation<double> _fabAnimation;

    bool _isFabMenuVisible = false;
    UserBloc get userBloc => context.read<UserBloc>();
    @override
    void initState() {
      _fabController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 260),
      );
      _fabAnimation = _fabController.curvedTweenAnimation(
        begin: 0.0,
        end: 1.0,
      );

      super.initState();
    }

    @override
    void dispose() {
      _fabController.dispose();

      super.dispose();
    }

    void _toggleFabMenu() {
      _isFabMenuVisible = !_isFabMenuVisible;

      if (_isFabMenuVisible) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    }

    void onPress([Function? callback]) {
      _toggleFabMenu();

      callback?.call();
    }

    @override
    Widget build(BuildContext context){
      final safeAreaBottom = MediaQuery.of(context).padding.bottom;

      return AnimatedOverlay(
        animation: _fabAnimation,
        color: Colors.black,
        onPress: _toggleFabMenu,
        child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 26, bottom: 26 + safeAreaBottom),
              child: ExpandedAnimationFab(
                animation: _fabAnimation,
                onPress: _toggleFabMenu,  
                items : [
                  FabItemData(
                    '회원 추가',
                    Icons.person_add_sharp,
                    onPress: () => onPress((){
                      showUserDialog(context);
                    }),
                  ),
                ]
              )
        )
      );
    }



    void showUserDialog(BuildContext context){
      showDialog(
        context : context,
        builder : (BuildContext context){
            final _formKey = GlobalKey<FormState>();
            final Map<String,TextEditingController> formController = {
              "name" : TextEditingController(),
              "phoneNumber" : TextEditingController()
            };
            return AlertDialog(
              content : Stack(
                children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key : _formKey,
                      child : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: formController['name'],
                              decoration: const InputDecoration(hintText : "이름"),
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return "이름을 입력해주세요.";
                                }
                                return null;
                            },),
                          ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: formController['phoneNumber'],
                                validator: (value) {
                                  RegExp phoneRegExp = new RegExp(r'^(?:\d{3}|\(\d{3}\))([-\/\.])\d{4}\1\d{4}$');
                                  if(value == null || value.isEmpty){
                                    return "전화번호를 입력해주세요.";
                                  }
                                  if(!phoneRegExp.hasMatch(value)){
                                    return "###-####-#### 형식으로 입력해주세요";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(hintText : "전화번호"),
                                
                                //  inputFormatters: [ 
                                //   FilteringTextInputFormatter.allow(RegExp('^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}')),
                                //  ],
                                // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],
            
                              ),
                            ),
                        ],
                      )
                    )
                ]
              ),
              actions: <Widget>[
                TextButton(
                  onPressed :() {
                    
                    
                      if(_formKey.currentState!.validate()){
                          
                          // To get data I wrote an extension method bellow
                          _formKey.currentState!.save();
                          final String name = formController['name']!.text.toString();
                          final String phoneNumber = formController['phoneNumber']!.text.toString();
                          final UserProperty userProperty = UserProperty(
                              name : name,
                              phoneNumber: phoneNumber
                          );
                          userBloc.add(UserCreated(userProperty)); 

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("추가되었습니다."),
                            )
                          );
                      };
                  }, 
                  child: Text("확인")
                ),
                TextButton(
                  onPressed :() {
                      Navigator.of(context).pop();
                  }, 
                  child: Text("취소")
                )
              ],
            );
        }
      );
       
       

    }
}