import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/job/job.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/models.dart';
import 'package:app/repositories/job_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateEditJobPage extends StatefulWidget {
  static const routeName = "/jobs/create_edit";
  final Job selectedJob;

  const CreateEditJobPage({Key key, this.selectedJob}) : super(key: key);

  @override
  _CreateEditJobPageState createState() => _CreateEditJobPageState();
}

class _CreateEditJobPageState extends State<CreateEditJobPage> {
  final _formKey = GlobalKey<FormState>();
  List<JobCategory> jobcategories;
  JobCategory selectedJobCategory;
  Map<String, dynamic> _job = {
    "deadline": DateTime.now(),
    "job_category_id": "6029b3c1a688f767edf6d0e3",
    "company_id": "60285807c314797e15dd419f",
    "job_type": "Contract"
  };

  @override
  void initState() {
    if (widget.selectedJob != null) {
      this._job["deadline"] = widget.selectedJob.deadline;
    }
    super.initState();
  }

  void onSelect(DateTime picked) {
    setState(() {
      this._job["deadline"] = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<JobCategory>> getCategories() async {
      final bloc = RepositoryProvider.of<JobCategoryRepository>(context);
      List<JobCategory> categories = await bloc.dataProvider.getJobCategories();
      return categories;
    }

    bool isEditing = widget.selectedJob != null;
    if (widget.selectedJob?.deadline != null) {
      _job["deadline"] = widget.selectedJob.deadline;
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: kSurfaceWhite,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.selectedJob != null ? "Edit Job" : "Create Job",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                buildJobTitleTextField(widget.selectedJob),
                SizedBox(
                  height: 10.0,
                ),
                buildJobPostionTextField(widget.selectedJob),
                SizedBox(
                  height: 20.0,
                ),
                buildExperienceLevelTextField(widget.selectedJob),
                SizedBox(
                  height: 20.0,
                ),
                buildJobDescriptionTextField(widget.selectedJob),
                SizedBox(
                  height: 20.0,
                ),
                buildJobOtherInfoTextField(widget.selectedJob),
                SizedBox(
                  height: 20.0,
                ),
                buildDatePicker(context),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: getCategories(),
                    builder:
                        (context, AsyncSnapshot<List<JobCategory>> snapshot) {
                      if (snapshot.hasData) {
                        return buildCategoryDropDown(snapshot.data);
                      } else {
                        return Container(
                          child: Text("Loading"),
                        );
                      }
                    }),
                SizedBox(
                  height: 20.0,
                ),
                buildJopType(),
                SizedBox(
                  height: 20.0,
                ),
                buildSubmitButton(
                    isEditing, context, widget.selectedJob, state.user)
              ]),
            ),
          ),
        ));
      }
      return Container();
    });
  }

  buildDatePicker(
    BuildContext context,
  ) {
    final DateFormat formatter = DateFormat.MMMEd();

    return ListTile(
      leading: Text(
        "Select Deadline",
        style: TextStyle(fontSize: 18.0),
      ),
      title: Text(formatter.format(this._job["deadline"]).toString()),
      trailing: IconButton(
        icon: Icon(Icons.date_range),
        onPressed: () => buildMaterialDatePicker(context),
      ),
    );
  }

  buildExperienceLevelTextField(Job selectedJob) {
    return Container(
        child: TextFormField(
      cursorHeight: 20.0,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Experience level';
        }
        return null;
      },
      onChanged: (text) {},
      initialValue: selectedJob != null ? selectedJob.experienceLevel : '',
      onSaved: (value) {
        setState(() {
          this._job["experience_level"] = value;
        });
      },
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: "Experience Level",
        labelStyle: TextStyle(color: kBrown300),
        hintText: 'BA, BSC, MSC, MA ...',
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  buildJobOtherInfoTextField(Job selectedJob) {
    return Container(
        child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter other info';
        }
        return null;
      },
      cursorHeight: 20.0,
      onChanged: (text) {},
      initialValue: selectedJob != null ? selectedJob.otherInfo : '',
      onSaved: (value) {
        setState(() {
          this._job["other_info"] = value;
        });
      },
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: "Enter Other Information",
        labelStyle: TextStyle(color: kBrown300),
        hintText: 'Other Info',
        hintMaxLines: 5,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  buildJobPostionTextField(Job selectedJob) {
    return Container(
        child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter job position';
        }
        return null;
      },
      cursorHeight: 20.0,
      initialValue: selectedJob != null ? selectedJob.jobPosition : '',
      onSaved: (value) {
        setState(() {
          this._job["job_position"] = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Job Position",
        labelStyle: TextStyle(color: kBrown300),
        hintText: 'Enter the position ...',
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  /// This builds material date picker in Android
  Future<void> buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      helpText: "Select Deadline Date",
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    if (picked != null) {
      onSelect(picked);
    }
  }

  Widget buildJopType() {
    List<String> job_types = [
      "FullTime",
      "Internship",
      "PartTime",
      "Contract",
      "Freelance"
    ]; // Option 2

    return Container(
      child: ListTile(
        leading: Text(
          "Select Job Type",
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: DropdownButton(
          value: this._job["job_type"],
          items: job_types.map((type) {
            return DropdownMenuItem(
              child: Text(type),
              value: type,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              this._job["job_type"] = value;
            });
          },
        ),
      ),
    );
  }

  buildCategoryDropDown(List<JobCategory> categories) {
    if (this.selectedJobCategory == null) {
      this.selectedJobCategory = categories[0];
    }

    return Container(
      child: ListTile(
        leading: Text(
          "Select Category",
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: DropdownButton(
          value: this.selectedJobCategory,
          items: categories.map((category) {
            return DropdownMenuItem(
              child: Text(category.name),
              value: category,
            );
          }).toList(),
          onChanged: (JobCategory selected) {
            setState(() {
              this._job["job_category_id"] = selected.id;
              this.selectedJobCategory = selected;
            });
          },
        ),
      ),
    );
  }

  Widget buildJobDescriptionTextField(Job selectedJob) {
    return Container(
        child: TextFormField(
      cursorHeight: 20.0,
      onChanged: (text) {},
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
      initialValue: selectedJob != null ? selectedJob.description : '',
      onSaved: (value) {
        setState(() {
          this._job["description"] = value;
        });
      },
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: "Enter Description",
        labelStyle: TextStyle(color: kBrown300),
        hintText: 'Description',
        hintMaxLines: 5,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  Widget buildJobTitleTextField(Job selectedJob) {
    return Container(
        child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Job title';
        }
        return null;
      },
      initialValue: selectedJob != null ? selectedJob.name : '',
      cursorHeight: 20.0,
      onChanged: (text) {
        setState(() {
          this._job["name"] = text;
        });
      },
      onSaved: (value) {
        setState(() {
          this._job["name"] = value;
        });
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: "Title",
        labelStyle: TextStyle(color: kBrown300),
        hintText: 'Enter of Job Title',
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBrown300, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  Widget buildSubmitButton(
      bool isEditing, BuildContext context, Job selectedJob, User currentUser) {
    return BlocConsumer<JobBloc, JobState>(listener: (context, JobState state) {
      if (state is JobOperationFailure) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("There is an error on creating or updating")),
        );
      } else if (state is JobsLoadedSuccess) {
        Navigator.of(context).pop();
        // BlocProvider.of<JobBloc>(context)
        // .add(JobLoad(userType: "employer", companyId: _job["company_id"]));
      }
    }, builder: (BuildContext context, JobState state) {
      // if (state is JobLoading) {
      //   return RaisedButton(
      //       padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //       onPressed: () {},
      //       color: kBrown400,
      //       textColor: Colors.white,
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      //         child: Text(isEditing ? "Updating" : "Creating",
      //             style: TextStyle(fontSize: 18.0)),
      //       ));
      // }
      return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            final form = _formKey.currentState;
            if (form.validate()) {
              form.save();
              Job job = Job(
                  deadline: this._job["deadline"],
                  jobType: this._job["job_type"],
                  experienceLevel: this._job["experience_level"],
                  datePublished: selectedJob != null
                      ? selectedJob.datePublished
                      : DateTime.now(),
                  name: this._job["name"],
                  companyId: this._job["company_id"],
                  categoryId: this._job["job_category_id"],
                  otherInfo: this._job["other_info"],
                  description: this._job["description"],
                  jobPosition: this._job["job_position"]);

              if (isEditing) {
                context
                    .read<JobBloc>()
                    .add(JobUpdate(selectedJob.id, job, currentUser));
              } else {
                print("company id is ${this._job["company_id"]}");
                context.read<JobBloc>().add(JobCreate(job, currentUser));
                // BlocProvider.of<JobBloc>(context).add(JobCreate(job));
              }
            }
          },
          color: kBrown400,
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(isEditing ? "Update" : "Create",
                style: TextStyle(fontSize: 18.0)),
          ));
    });
  }
}
