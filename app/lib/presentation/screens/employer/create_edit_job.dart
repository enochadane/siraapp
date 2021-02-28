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
  @override
  _CreateEditJobPageState createState() => _CreateEditJobPageState();
}

class _CreateEditJobPageState extends State<CreateEditJobPage> {
  final _formKey = GlobalKey<FormState>();
  final User user = null;
  Map<String, dynamic> _job = {
    "deadline": DateTime.now(),
    "job_category_id": "6029b3c1a688f767edf6d0e3",
    "company_id": "60285807c314797e15dd419f",
    "job_type": "Contract"
  };

  @override
  void initState() {
    super.initState();
  }

  void onSelect(DateTime picked) {
    setState(() {
      this._job["deadline"] = picked;
    });
  }

  Future<List<JobCategory>> getCategories(context) async {
    final bloc = RepositoryProvider.of<JobCategoryRepository>(context);
    return await bloc.dataProvider.getJobCategories();
  }

  @override
  Widget build(BuildContext context) {
    Job selectedJob = ModalRoute.of(context).settings.arguments;

    bool isEditing = selectedJob != null;
    if (selectedJob?.deadline != null) {
      _job["deadline"] = selectedJob.deadline;
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state){
          if(state is AuthenticationAuthenticated){
        return  SafeArea(
          child: Scaffold(
        backgroundColor: kSurfaceWhite,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                      selectedJob != null ? "Edit Job" : "Create Job",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              buildJobTitleTextField(selectedJob),
              SizedBox(
                height: 10.0,
              ),
              buildJobPostionTextField(selectedJob),
              SizedBox(
                height: 20.0,
              ),
              buildExperienceLevelTextField(selectedJob),
              SizedBox(
                height: 20.0,
              ),
              buildJobDescriptionTextField(selectedJob),
              SizedBox(
                height: 20.0,
              ),
              buildJobOtherInfoTextField(selectedJob),
              SizedBox(
                height: 20.0,
              ),
              buildDatePicker(context),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: getCategories(context),
                  builder: (context, AsyncSnapshot<List<JobCategory>> snapshot) {
                    return buildCategoryDropDown(snapshot.data);
                  }),
              SizedBox(
                height: 20.0,
              ),
              buildJopType(),
              SizedBox(
                height: 20.0,
              ),
              buildSubmitButton(isEditing, context, selectedJob, state.user)
            ]),
          ),
        ),
      )
    );}
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
    JobCategory getSelectedCategory = categories[0];
    if (this._job["job_category_id"] != null) {
      getSelectedCategory = categories.firstWhere(
          (category) => category.id == this._job["job_category_id"]);
    }
    return Container(
      child: ListTile(
        leading: Text(
          "Select Category",
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: DropdownButton(
          value: getSelectedCategory,
          items: categories.map((category) {
            return DropdownMenuItem(
              child: Text(category.name),
              value: category,
            );
          }).toList(),
          onChanged: (JobCategory selected) {
            setState(() {
              this._job["job_category_id"] = selected.id;
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
    return BlocConsumer<JobBloc, JobState>(
      listener: (context, JobState state) {
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
       if (state is JobLoading) {
        return RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {},
            color: kBrown400,
            textColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Text(isEditing ? "Updating" : "Creating",
                  style: TextStyle(fontSize: 18.0)),
            ));
      } 
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
                context.read<JobBloc>().add(JobUpdate(selectedJob.id, job, currentUser));
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
