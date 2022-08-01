import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/show_comments.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/shared/components/components.dart';

var commentController = TextEditingController();

class CommentsScreen extends StatelessWidget {
  final int productId;
  const CommentsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppMakeCommentSuccessState) {
          if (state.model!.status == 'true') {
            showToast(
                text: 'Your comment has been added successfully',
                state: ToastStates.success);
            commentController.text = '';
            Navigator.pop(context);
          } else {
            showToast(
                text: 'Can\'t add your comment', state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Comments'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(AppCubit.get(context)
                              .profileModel
                              ?.message
                              ?.profilePicture ??
                          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=626&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        // expands: true,
                        controller: commentController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (commentController.text != '') {
                                    print(productId.runtimeType);
                                    AppCubit.get(context).MakeComment(
                                        text: commentController.text,
                                        productId: productId);
                                  }
                                },
                                icon: Icon(Icons.send)),
                            label: Text('write your comment ....'),
                            border: const UnderlineInputBorder(),
                            fillColor: Colors.grey[200]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (AppCubit.get(context).comments.isNotEmpty)
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildCommentItem(
                              AppCubit.get(context).showComments?.data?[index],
                              context),
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                          itemCount: AppCubit.get(context).comments.length)),
                // Container(
                //   color: Colors.red,
                //   height: 40,
                //   width: 200,
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildCommentItem(CommentShow? comment, context) => Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          AppCubit.get(context).deleteComment(
              commentId: comment!.id!,
              productId: int.parse(comment.productId!));
          // AppCubit.get(context).getAllComments(productId: comment.id!);
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(comment
                    ?.usercomment?.profilePicture ??
                'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=626&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),

              // height: 50,

              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment?.usercomment?.name ?? '',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      comment?.comment ?? '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget buildDialog(context) {
  return Dialog(
    insetAnimationCurve: Curves.linearToEaseOut,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Container(
      padding: EdgeInsets.all(20),
      height: 150,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Do you want to delete this data ?',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    // fun(id);
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('yes'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('No'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class Data {
  final String? id;
  final String? title;

  Data({this.id, this.title});
}
