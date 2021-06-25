import 'package:bodysculpting/models/link.dart';
import 'package:bodysculpting/models/program.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatastore {
  static const currentVersion = 1;

  Future<void> init() async {
    print('LocalDatastore.init()');
    await Hive.initFlutter("bodysculpting");

    //
    // register type adapters
    //
    Hive.registerAdapter(LinkAdapter());
    Hive.registerAdapter(ProgramLevelAdapter());
    Hive.registerAdapter(ProgramAdapter());

    //
    // create initial database or update to newer schema version
    //
    var schema = await Hive.openBox('schema');
    var version = schema.get('version');

    print('schema version: $version');

    switch (version) {
      case null:
        {
          print('create fresh new database');
          await _create();
          schema.put('version', currentVersion);
        }
        break;
    }
  }

  // Create default dataset (settings, exercises, programs, routines, etc.)
  Future<void> _create() async {
    var programs = await Hive.openBox<Program>('programs');

    //
    // programs
    //

    // StrongLifts
    var program = Program(
      id: 'stronglifts',
      name: 'StrongLifts 5x5',
      description: 'This is some description\nMultiline?\nyes',
      daysPerWeek: 3,
      levels: [
        ProgramLevel.novice,
        ProgramLevel.intermediate,
        ProgramLevel.advanced
      ],
      links: [],
      routines: [],
    );
    programs.put(program.id, program);

    // Cowboy Method
    program = Program(
      id: 'cowboy',
      name: 'Cowboy Method',
      description: 'This is a variation of the Texas Method for novice lifters',
      daysPerWeek: 3,
      levels: [ProgramLevel.novice],
      links: [],
      routines: [],
    );
    programs.put(program.id, program);

    // Texas Method
    program = Program(
      id: 'texas',
      name: 'Texas Method',
      description: 'Texas Method is good for intermediate to advanced lifters',
      daysPerWeek: 3,
      levels: [ProgramLevel.intermediate, ProgramLevel.advanced],
      links: [],
      routines: [],
    );
    programs.put(program.id, program);

    // Wendler 5/3/1
    program = Program(
      id: 'wendler',
      name: 'Wendler 5/3/1',
      description: 'Wendler description goes here',
      daysPerWeek: 5,
      levels: [ProgramLevel.advanced],
      links: [],
      routines: [],
    );
    programs.put(program.id, program);

    // Ivysaur 4-4-8
    program = Program(
      id: 'ivysaur',
      name: 'Ivysaur 4-4-8',
      description:
          'Alternative to 5x5 that focuses slightly more on upper body strength and hypertrophic aid',
      daysPerWeek: 3,
      levels: [
        ProgramLevel.novice,
        ProgramLevel.intermediate,
        ProgramLevel.advanced
      ],
      links: [],
      routines: [],
    );
    programs.put(program.id, program);

    // Strong Curves: Bootyful Beginnings
    program = Program(
      id: 'bootyful-beginnings',
      name: 'Strong Curves: Bootyful Beginnings',
      description: 'novice',
      levels: [ProgramLevel.novice],
      daysPerWeek: 3,
      links: [
        Link(
          name: 'Strong Curves Spreadsheets + PDF',
          url:
              'https://liftvault.com/programs/strength/strong-curves-program-spreadsheet/',
        )
      ],
      routines: [],
    );
    programs.put(program.id, program);

    // Strong Curves: Gluteal Goddess
    program = Program(
      id: 'gluteal-goddess',
      name: 'Strong Curves: Gluteal Goddess',
      description: 'intermediate',
      daysPerWeek: 3,
      levels: [ProgramLevel.intermediate],
      links: [
        Link(
          name: 'Strong Curves Spreadsheets + PDF',
          url:
              'https://liftvault.com/programs/strength/strong-curves-program-spreadsheet/',
        )
      ],
      routines: [],
    );
    programs.put(program.id, program);

    // Strong Curves: Gorgeous Glutes
    program = Program(
      id: 'gorgeous-glutes',
      name: 'Strong Curves: Gorgeous Glutes',
      description: 'advanced',
      daysPerWeek: 3,
      levels: [ProgramLevel.advanced],
      links: [
        Link(
          name: 'Strong Curves Spreadsheets + PDF',
          url:
              'https://liftvault.com/programs/strength/strong-curves-program-spreadsheet/',
        )
      ],
      routines: [],
    );
    programs.put(program.id, program);
  }
}
